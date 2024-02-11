(This file may become the seed of a exercise-generate script.)

# creating the Bob exercise

1. create the directory structure:

    ```sh
    bin/fetch-configlet
    slug=bob
    bin/configlet create --practice-exercise $slug
    ```

2. create the data.csv file from canonical data

    ```sh
    cd exercises/practice/$slug
    cp "${XDG_CACHE_DIR:-$HOME/.cache}"/exercism/configlet/problem-specifications/exercises/$slug/canonical-data.json .

    # This needs to be custom crafted per exercise.
    # for exaple, for "bob"
    jq -r '.cases[] | [.input.heyBob, ""] | @csv' canonical-data.json > data.csv

    # and for "high-scores", the canonical data has nested cases
    jq -r '
      ( .cases
        | map(select(has("uuid")))
        + map(select(has("cases")) | .cases)[]
      )[]
      | .uuid as $u
      | .input.scores[]
      | [$u, .]
      | @csv
    ' canonical-data.json > data.csv
    ```

3. create the `create_test_table.sql` from canonical data

    ```sh
    #!/usr/bin/env bash
    {
    cat << '--END-SQL--'
    DROP TABLE IF EXISTS tests;
    CREATE TABLE IF NOT EXISTS tests (
        -- uuid and description are taken from the test.toml file
        uuid TEXT PRIMARY KEY,
        description TEXT NOT NULL,
        -- The following section is needed by the online test-runner
        status TEXT DEFAULT 'fail',
        message TEXT,
        output TEXT,
        test_code TEXT,
        task_id INTEGER DEFAULT NULL,
        -- Here are columns for the actual tests
        property TEST NOT NULL,
        input INT NOT NULL,
        expected TEXT NOT NULL
    );

    -- Note: the strings below _may_ literal tab, newline, carriage returns.

    INSERT INTO tests (uuid, description, property, input, expected)
        VALUES
    --END-SQL--

    # The following may need to be custom crafted per exercise (this is high-scores)
    jq -r --arg q "'" '
        ( .cases
          | map(select(has("uuid")))
          + map(select(has("cases")) | .cases)[]
        )[]
        | [
            .uuid,
            .description,
            .property,
            (.input.scores | join(",")),
            (.expected | if type == "array" then join(",") else . end)
        ]
        | @csv
        | gsub($q; $q+$q)
        | gsub("\""; $q)
        | "        (" + . + "),"
    ' canonical-data.json | sed -E '$s/,$/;/'
    } > create_test_table.sql
    ```

3. create the `create_fixture.sql` file
4. create the `${slug}_test.sql` file based on the test script from another exercise.
5. create `.meta/example.sql`
6. set the stub file.
7. test it.

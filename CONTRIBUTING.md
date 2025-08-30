# Contributing

If you have not contributed previously to one of the Exercism tracks, we strongly recommend discussing any changes on [the forum][forum] _before_ creating any PR.

## Formatting

All `.sql` files in this repo should be formatted using [the `sql-formatter` tool][sql-formatter].
This provides a single, consistent way to format SQL.

The `sql-formatter` does not properly handle [SQLite dot commands][dot-commands].
The following `bash` script can be used to wrap `sql-formatter` without breaking on dot commands by temporarily turning them into comments.

```bash
#!/bin/env bash
sed -i 's/^\./--T./' "$@"
sql-formatter --fix -l sqlite "$@"
sed -i 's/^--T\././' "$@"
```

## Creating a new exercise

(These instructions may become the seed of a exercise-generate script.)

The steps below walk you through creating a new "bob" exercise.
They provide most the steps needed to create a new practice exercise.

1. create the directory structure:

    ```sh
    bin/fetch-configlet
    slug=bob
    bin/configlet create --practice-exercise "$slug"
    ```

1. create the data.csv file from canonical data

    ```sh
    cd "exercises/practice/$slug"
    cp "${XDG_CACHE_DIR:-$HOME/.cache}/exercism/configlet/problem-specifications/exercises/$slug/canonical-data.json" .

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

1. create the `create_test_table.sql` from canonical data

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

    -- Note: the strings below _may_ contain literal tab, newline, or carriage returns.

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

1. create the `create_fixture.sql` file
1. create the `${slug}_test.sql` file based on the test script from another exercise.
1. create `.meta/example.sql`
1. set the stub file.
1. test it.

[forum]: https://forum.exercism.org/c/programming/sqlite/430
[sql-formatter]: https://github.com/sql-formatter-org/sql-formatter
[dot-commands]: https://www.sqlite.org/cli.html#special_commands_to_sqlite3_dot_commands_

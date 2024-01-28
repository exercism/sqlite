(This file may become the seed of a exercise-generate script.)

# creating the Bob exercise

1. create the directory structure:

    ```sh
    bin/fetch-configlet
    bin/configlet create --practice-exercise bob
    ```

2. create the data.csv file from canonical data

    ```sh
    cd exercises/practice/bob
    cp ~/.cache/exercism/configlet/problem-specifications/exercises/bob/canonical-data.json .
    jq -r '.cases[] | [.input.heyBob, ""] | @csv' canonical-data.json > data.csv
    ```

3. create the create_test_table.sql from canonical data

    ```sh
    #!/usr/bin/env bash

    cat > create_test_table.sql << '--END-SQL--'
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
        input INT NOT NULL,
        expected TEXT NOT NULL
    );

    -- Note: the strings below contain literal tab, newline, carriage returns.

    INSERT INTO tests (uuid, description, input, expected)
        VALUES
    --END-SQL--

    jq -r '
        .cases[]
        | [.uuid, .description, .input.heyBob, .expected]
        | @csv
        | "        (\(.)),"
    ' canonical-data.json >> create_test_table.sql

    sed -i -E '$s/,$/;/' create_test_table.sql
    ```

3. create the create_fixture.sql file
4. create the bob_test.sql file based on the test script from another exercise.
5. create the example.sql
6. set the stub file.
7. test it.

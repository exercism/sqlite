# Tests

To run the tests for your SQLite exercises, follow these steps:

1. Open your preferred terminal.
2. Navigate to the directory containing the appropriate `${slug}_test.sql` file, where `${slug}` is the name of the exercise, using hyphens instead of spaces and all lowercase.
3. Execute the following command: 
```bash
sqlite3 -bail < ${slug}_test.sql
```
  
This command initializes SQLite with an empty database, runs the tests specified in `${slug}_test.sql`, and exits afterward.
`-bail` will make sure the code execution stops for invalid code.

The test results will be displayed in the console as a table, showing the description of each test, its status (e.g., "pass"), and a message if the status is "fail."

## Execution Details

The test file (`${slug}_test.sql`) is a pretty complex script.
Here is an overview of what it does.

1. Sets up tables by reading `create_fixture.sql`.
   This creates tables then populates them with values from `data.csv` for valid data and `error_data.csv` for entries that should fail.
   Only those tables are checked during tests; changes to other tables are ignored.
2. Runs the solution code by reading the `${slug}.sql` file.
3. Creates tables to hold test cases and results.
4. Populates the test results based on the data in the table(s) updated by the solution.
5. Displays test results (pass or fail and optional details).
These CSV files contain the necessary data for testing various scenarios.

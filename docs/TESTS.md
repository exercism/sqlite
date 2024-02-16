# Tests

To run the tests for your SQLite exercises, follow these steps:

1. Open your preferred terminal.
2. Navigate to the directory containing the appropriate `STUB_test.sql` file, where `STUB` is the name of the exercise, using hyphens instead of spaces and all lowercase.
3. Execute the following command: 
```bash
sqlite3 '' --init STUB_test.sql -bail '.exit'
```
  
This command initializes SQLite with an empty database, runs the tests specified in STUB_test.sql, and exits afterward.
`-bail` will make sure the code execution stops for invalid code.

The test results will be displayed in the console as a table, showing the description of each test, its status (e.g., "passed"), and a message if the status is not "passed."

## Execution Details

For those interested in understanding the test file (STUB_test.sql), it prepares the initial database by populating it with values from `data.csv` for valid data and `error_data.csv` for entries that should fail.
These CSV files contain the necessary data for testing various scenarios.

-- Create database:
.read ./create_fixture.sql

-- Read user student solution and save any output as markdown in user_output.md:
.mode markdown
.output user_output.md
.read ./queen-attack.sql
.output

-- Create a clean testing environment:
.read ./create_test_table.sql

-- Comparison of user input and the tests updates the status for each test:
UPDATE tests
   SET status = 'pass'
  FROM (SELECT white_row, white_col, black_row, black_col, result, error
          FROM "queen-attack") AS actual
 WHERE (actual.white_row, actual.white_col, actual.black_row, actual.black_col)
     = ( tests.white_row,  tests.white_col,  tests.black_row,  tests.black_col)
   AND (actual.result = tests.expected_result
        OR (actual.result ISNULL AND tests.expected_result ISNULL))
   AND (actual.error = tests.expected_error
        OR (actual.error ISNULL AND tests.expected_error ISNULL))
;

-- Update message for failed tests to give helpful information:
UPDATE tests
   SET message = (
         'Result for "'
         || PRINTF('white(row,col)=(%d,%d), black(row,col)=(%d,%d)',
                   actual.white_row, actual.white_col,
                   actual.black_row, actual.black_col)
         || '"' || ' is <'
         || PRINTF('result=%s and error=%s',
                   COALESCE(actual.result, 'NULL'),
                   COALESCE(actual.error,  'NULL'))
         || '> but should be <'
         || PRINTF('result=%s and error=%s',
                   COALESCE(tests.expected_result, 'NULL'),
                   COALESCE(tests.expected_error,  'NULL'))
         || '>'
  )
  FROM (SELECT white_row, white_col, black_row, black_col, result, error
          FROM "queen-attack") AS actual
 WHERE (actual.white_row, actual.white_col, actual.black_row, actual.black_col)
     = ( tests.white_row,  tests.white_col,  tests.black_row,  tests.black_col)
   AND tests.status = 'fail';

-- Save results to ./output.json (needed by the online test-runner)
.mode json
.once './output.json'
SELECT
  description,
  status,
  message,
  output,
  test_code,
  task_id
FROM
  tests;

-- Display test results in readable form for the student:
.mode table
SELECT
  description,
  status,
  message
FROM
  tests;

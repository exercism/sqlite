-- Create database:
.read ./create_fixture.sql
-- Read user student solution and save any output as markdown in user_output.md:
.mode markdown
.output user_output.md
.read ./series.sql
.output
-- Create a clean testing environment:
.read ./create_test_table.sql
-- Comparison of user input and the tests updates the status for each test:
UPDATE tests
SET
  status = 'pass'
FROM
  (
    SELECT
      input,
      slice_length,
      result,
      error
    FROM
      series
  ) AS actual
WHERE
  (actual.input, actual.slice_length) = (tests.input, tests.slice_length)
  AND (
    actual.result = tests.expected_result
    OR COALESCE(actual.result, tests.expected_result) ISNULL
  )
  AND (
    actual.error = tests.expected_error
    OR COALESCE(actual.error, tests.expected_error) ISNULL
  );

-- Update message for failed tests to give helpful information:
UPDATE tests
SET
  message = (
    'Result for "' || PRINTF(
      'input=''%s'' and slice_length=''%s''',
      actual.input,
      actual.slice_length
    ) || '"' || ' is <' || PRINTF(
      'result=%s and error="%s"',
      COALESCE(actual.result, 'NULL'),
      COALESCE(actual.error, 'NULL')
    ) || '> but should be <' || PRINTF(
      'result=%s and error="%s"',
      COALESCE(tests.expected_result, '"NULL"'),
      COALESCE(tests.expected_error, 'NULL')
    ) || '>'
  )
FROM
  (
    SELECT
      input,
      slice_length,
      result,
      error
    FROM
      series
  ) AS actual
WHERE
  (actual.input, actual.slice_length) = (tests.input, tests.slice_length)
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

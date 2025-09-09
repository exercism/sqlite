-- Create database:
.read ./create_fixture.sql
-- Read user student solution and save any output as markdown in user_output.md:
.mode markdown
.output user_output.md
.read ./food-chain.sql
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
      start_verse,
      end_verse,
      result
    FROM
      "food-chain"
  ) AS actual
WHERE
  (
    actual.start_verse,
    actual.end_verse,
    actual.result
  ) = (
    tests.start_verse,
    tests.end_verse,
    tests.expected
  );

-- Update message for failed tests to give helpful information:
UPDATE tests
SET
  message = (
    'Result for "' || PRINTF(
      'start_verse=%d, end_verse=%d',
      tests.start_verse,
      tests.end_verse
    ) || '"' || ' is <' || COALESCE(actual.result, 'NULL') || '> but should be <' || tests.expected || '>'
  )
FROM
  (
    SELECT
      start_verse,
      end_verse,
      result
    FROM
      "food-chain"
  ) AS actual
WHERE
  (actual.start_verse, actual.end_verse) = (tests.start_verse, tests.end_verse)
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

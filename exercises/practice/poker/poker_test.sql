-- Create database:
.read ./create_fixture.sql
-- Read user student solution and save any output as markdown in user_output.md:
.mode markdown
.output user_output.md
.read ./poker.sql
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
      hands,
      result
    FROM
      poker
  ) AS actual
WHERE
  JSON(actual.hands) = JSON(tests.hands)
  AND (
    SELECT
      JSON_GROUP_ARRAY(hand)
    FROM
      (
        SELECT
          j.value hand
        FROM
          JSON_EACH(actual.result) j
        ORDER BY
          hand
      )
  ) = (
    SELECT
      JSON_GROUP_ARRAY(hand)
    FROM
      (
        SELECT
          j.value hand
        FROM
          JSON_EACH(tests.expected) j
        ORDER BY
          hand
      )
  );

-- Update message for failed tests to give helpful information:
UPDATE tests
SET
  message = (
    'Result for "' || tests.hands || '"' || ' is <' || COALESCE(actual.result, 'NULL') || '> but should be <' || tests.expected || '>'
  )
FROM
  (
    SELECT
      hands,
      result
    FROM
      poker
  ) AS actual
WHERE
  actual.hands = tests.hands
  AND tests.status = 'fail';

-- Save results to ./output.json (needed by the online test-runner)
.mode json
.once './output.json'
SELECT
  description,
  status,
  message,
  OUTPUT,
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

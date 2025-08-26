-- Create database:
.read ./create_fixture.sql

-- Read user student solution and save any output as markdown in user_output.md:
.mode markdown
.output user_output.md
.read ./saddle-points.sql
.output

-- Create a clean testing environment:
.read ./create_test_table.sql

-- Comparison of user input and the tests updates the status for each test:
UPDATE tests
  SET status = 'pass'
  FROM (SELECT matrix, result FROM "saddle-points") AS actual
  WHERE actual.matrix = tests.matrix
  AND IIF(
    actual.matrix ISNULL,
    (
      SELECT JSON_GROUP_ARRAY(JSON(value))
        FROM (
          SELECT j.value
            FROM JSON_EACH(actual.result) j
           ORDER BY j.VALUE
        )
    ),
    actual.result
  ) =
  (
    SELECT JSON_GROUP_ARRAY(JSON(value))
      FROM (SELECT j.value FROM JSON_EACH(tests.expected) j ORDER BY j.value)
  )
;

-- Update message for failed tests to give helpful information:
UPDATE tests
  SET message = (
    'Result for "'
    || tests.matrix
    || '"'
    || ' is <' || COALESCE(actual.result, 'NULL')
    || '> but should be <' || tests.expected || '>'
)
FROM (SELECT matrix, result FROM "saddle-points") AS actual
WHERE actual.matrix = tests.matrix AND tests.status = 'fail';

-- Save results to ./output.json (needed by the online test-runner)
.mode json
.once './output.json'
SELECT description, status, message, output, test_code, task_id
FROM tests;

-- Display test results in readable form for the student:
.mode table
SELECT description, status, message
FROM tests;

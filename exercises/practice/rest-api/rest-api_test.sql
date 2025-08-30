-- Create database:
.read ./create_fixture.sql
-- Read user student solution and save any output as markdown in user_output.md:
.mode markdown
.output user_output.md
.read ./rest-api.sql
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
      database,
      url,
      payload,
      result
    FROM
      'rest-api'
  ) AS actual
WHERE
  (actual.database, actual.url, actual.payload) = (tests.database, tests.url, tests.payload)
  AND (
    SELECT
      COUNT(*)
    FROM
      json_tree(actual.result) as a,
      json_tree(tests.expected) as b
    WHERE
      (a.fullkey, a.atom) IS (b.fullkey, b.atom)
  ) = (
    SELECT
      COUNT(*)
    FROM
      json_tree(tests.expected)
  )
  AND (
    SELECT
      COUNT(*)
    FROM
      json_tree(tests.expected)
  ) = (
    SELECT
      COUNT(*)
    FROM
      json_tree(actual.result)
  );

-- Update message for failed tests to give helpful information:
UPDATE tests
SET
  message = 'Result for ' || tests.database || ' as ' || tests.payload || ' is ' || actual.result || ', but should be ' || tests.expected
FROM
  (
    SELECT
      database,
      payload,
      url,
      result
    FROM
      'rest-api'
  ) AS actual
WHERE
  (actual.database, actual.payload, actual.url) = (tests.database, tests.payload, tests.url)
  AND tests.status = 'fail';

-- Save results to ./output.json (needed by the online test-runner)
.mode json
.once './output.json'
SELECT
  name,
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
  name,
  status,
  message
FROM
  tests;

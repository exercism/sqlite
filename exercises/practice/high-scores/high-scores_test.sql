-- Create database:
.read ./create_fixture.sql

-- Read user student solution and save any output as markdown in user_output.md:
.mode markdown
.output user_output.md
.read ./high-scores.sql
.output

-- Create a clean testing environment:
.read ./create_test_table.sql

-- Update the status for each test:
UPDATE tests
SET status = 'pass'
FROM (SELECT uuid, result FROM results) AS actual
WHERE (actual.uuid, actual.result) = (tests.uuid, tests.expected);

-- Update message for failed tests to give helpful information:
UPDATE tests
SET message = 'Result for "' || tests.description || '" is "' || actual.result || '", but should be "' || tests.expected || '"'
FROM (SELECT uuid, result FROM results) AS actual
WHERE actual.uuid = tests.uuid AND tests.status = 'fail';

-- Save results to ./output.json (needed by the online test-runner)
.mode json
.once './output.json'
SELECT description, status, message, output, test_code, task_id
FROM tests;

-- Display test results in readable form for the student:
.mode table
SELECT description, status, message
FROM tests;


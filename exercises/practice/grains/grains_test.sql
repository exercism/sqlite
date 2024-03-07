-- Create database:
.read ./create_fixture.sql

-- Read user student solution and save any output as markdown in user_output.md:
.mode markdown
.output user_output.md
.read ./grains.sql
.output

-- Create a clean testing environment:
.read ./create_test_table.sql

-- Comparison of user input and the tests updates the status for each test:
UPDATE tests
SET status = 'pass'
FROM (SELECT task, square, result FROM grains) AS actual
WHERE (actual.task, actual.square, actual.result) = (tests.task, tests.square, tests.expected);

-- Update message for failed tests to give helpful information:
UPDATE tests
SET message = 'Result for ' || tests.task || ' as ' || tests.square || ' is ' || actual.result || ', but should be ' || tests.expected
FROM (SELECT  task, square, result FROM grains) AS actual
WHERE (actual.task, actual.square) = (tests.task, tests.square) AND tests.status = 'fail';

-- Save results to ./output.json (needed by the online test-runner)
.mode json
.once './output.json'
SELECT name, status, message, output, test_code, task_id
FROM tests;

-- Display test results in readable form for the student:
.mode table
SELECT name, status, message
FROM tests;

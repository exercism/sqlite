-- Create database:
.read ./create_fixture.sql

-- Read user student solution and save any output as markdown in user_output.md:
.mode markdown
.output user_output.md
.read ./difference-of-squares.sql
.output

-- Create a clean testing environment:
.read ./create_test_table.sql

-- Comparison of user input and the tests updates the status for each test:
UPDATE tests
SET status = 'pass'
FROM (SELECT number, property, result FROM "difference-of-squares") AS actual
WHERE (actual.number, actual.property, actual.result) = (tests.number, tests.property, tests.expected);

-- Update message for failed tests to give helpful information:
UPDATE tests
SET message = 'Result for ' || tests.number || ' is ' || actual.result || ', but should be ' || tests.expected
FROM (SELECT number,  property, result FROM "difference-of-squares") AS actual
WHERE (actual.number, actual.property) = (tests.number, tests.property) AND tests.status = 'fail';

-- Save results to ./output.json (needed by the online test-runner)
.mode json
.once './output.json'
SELECT name, status, message, output, test_code, task_id
FROM tests;

-- Display test results in readable form for the student:
.mode table
SELECT name, status, message
FROM tests;

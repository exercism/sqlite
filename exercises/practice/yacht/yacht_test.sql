-- Create database:
.read ./create_fixture.sql

-- Read user student solution and save any output as markdown in user_output.md:
.mode markdown
.output user_output.md
.read ./yacht.sql
.output

-- Create a clean testing environment:
.read ./create_test_table.sql

-- Comparison of user input and the tests updates the status for each test:
UPDATE tests
SET status = 'pass'
FROM (SELECT dice_results, category, result FROM yacht) AS actual
WHERE (actual.dice_results, actual.category, actual.result) = (tests.dice_results, tests.category, tests.expected);

-- Update message for failed tests to give helpful information:
UPDATE tests
SET message = 'Result for ' || tests.dice_results || ' as ' || tests.category || ' is ' || actual.result || ', but should be ' || tests.expected
FROM (SELECT  dice_results, category, result FROM yacht) AS actual
WHERE (actual.dice_results, actual.category) = (tests.dice_results, tests.category) AND tests.status = 'fail';

-- Save results to ./output.json (needed by the online test-runner)
.mode json
.once './output.json'
SELECT name, status, message, output, test_code, task_id
FROM tests;

-- Display test results in readable form for the student:
.mode table
SELECT name, status, message
FROM tests;

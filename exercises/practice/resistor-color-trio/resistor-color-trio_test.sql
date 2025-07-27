-- Create database:
.read ./create_fixture.sql

-- Read user student solution and save any output as markdown in user_output.md:
.mode markdown
.output user_output.md
.read ./resistor-color-trio.sql
.output

-- Create a clean testing environment:
.read ./create_test_table.sql

-- Comparison of user input and the tests updates the status for each test:
UPDATE tests
SET status = 'pass'
FROM (SELECT color1, color2, color3, result FROM color_code) AS actual
WHERE (actual.color1, actual.color2, actual.color3, actual.result) = (tests.color1, tests.color2, tests.color3, tests.expected);

-- Update message for failed tests to give helpful information:
UPDATE tests
SET message = (
    'Result for "'
    || CONCAT(tests.color1, ',', tests.color2, ',', tests.color3)
    || '"'
    || ' is <' || COALESCE(actual.result, 'NULL')
    || '> but should be <' || tests.expected || '>'
)
FROM (SELECT color1, color2, color3, result FROM color_code) AS actual
WHERE (actual.color1, actual.color2, actual.color3) = (tests.color1, tests.color2, tests.color3) AND tests.status = 'fail';

-- Save results to ./output.json (needed by the online test-runner)
.mode json
.once './output.json'
SELECT description, status, message, output, test_code, task_id
FROM tests;

-- Display test results in readable form for the student:
.mode table
SELECT description, status, message
FROM tests;

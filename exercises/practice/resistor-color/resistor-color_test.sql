-- Create database:
.read ./create_fixture.sql

-- Read user student solution and save any output as markdown in user_output.md:
.mode markdown
.output user_output.md
.read ./resistor-color.sql
.output

-- Create a clean testing environment:
.read ./create_test_table.sql

-- Comparison of user input and the tests updates the status for each test:
UPDATE "test_color_code"
SET status = 'pass'
FROM (SELECT color, result FROM color_code) AS got
WHERE (got.color, got.result) = (test_color_code.color, test_color_code.result);
-- Update message for failed tests to give helpful information:
UPDATE test_color_code
SET message = 'Result for ' || got.color || ' is "' || got.result || '", but should be: "' || test_color_code.result || '"'
FROM (SELECT color, result FROM color_code) AS got
WHERE got.color = test_color_code.color AND test_color_code.status = 'fail';


.mode json
.once './output.json'
SELECT description, status, message, output, test_code, task_id
FROM "test_color_code";

-- Display test results in readable form for the student:
.mode table
SELECT description, status, message
FROM "test_color_code";

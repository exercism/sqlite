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
FROM (SELECT color, result FROM color_code) AS l
WHERE (l.color, l.result) = (test_color_code.color, test_color_code.result);
-- Update message for failed tests to give helpful information:
UPDATE test_color_code
SET message = 'Result for ' || l.color || ' is "' || l.result || '", but should be: "' || test_color_code.result || '"'
FROM (SELECT color, result FROM color_code) AS l
WHERE l.color = test_color_code.color AND test_color_code.status = 'fail';

-- Comparison of user input and the tests updates the status for each test:
UPDATE test_colors
SET status = 'pass'
FROM (SELECT GROUP_CONCAT("color" ORDER BY "index") as "result" FROM "colors") AS l
WHERE l.result = test_colors.result;
-- Update message for failed tests to give helpful information:
UPDATE test_colors
SET message = 'Result for Colors is "' || l.result || '", but should be: "' || test_colors.result || '"'
FROM (SELECT GROUP_CONCAT("color" ORDER BY "index") as "result" FROM "colors") AS l
WHERE test_colors.status = 'fail';

INSERT INTO test_results (uuid, description, test_name, status, message, output, test_code, task_id)
SELECT uuid, description, 'color', status, message, '', '', '' FROM test_colors;
INSERT INTO test_results (uuid, description, test_name, status, message, output, test_code, task_id)
SELECT uuid, description, 'color code', status, message, '', '', '' FROM test_color_code;
.mode json
.once './output.json'
SELECT description, status, message, output, test_code, task_id
FROM test_results;

-- Display test results in readable form for the student:
.mode table
SELECT description, status, message
FROM test_results;

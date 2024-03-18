-- Update message for failed tests to give helpful information:
UPDATE test_color_code
SET message = 'Result for ' || actual.color || ' is "' || actual.result || '", but should be: "' || test_color_code.result || '"'
FROM (SELECT color, result FROM color_code) AS actual
WHERE actual.color = test_color_code.color AND test_color_code.status = 'fail';


.mode json
.once './output.json'
SELECT description, status, message, output, test_code, task_id
FROM "test_color_code";

-- Display test results in readable form for the student:
.mode table
SELECT description, status, message
FROM "test_color_code";

-- Update message for failed tests to give helpful information:
UPDATE tests
SET message = 'Result for "' || tests.description || '" is "' || actual.result || '", but should be "' || tests.expected || '"'
FROM (SELECT game_id, result FROM results) AS actual
WHERE actual.game_id = tests.uuid AND tests.status = 'fail';

-- Save results to ./output.json (needed by the online test-runner)
.mode json
.once './output.json'
SELECT description, status, message, output, test_code, task_id
FROM tests;

-- Display test results in readable form for the student:
.mode table
SELECT description, status, message
FROM tests;

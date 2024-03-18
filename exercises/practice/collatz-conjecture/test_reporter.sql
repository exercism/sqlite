-- Update message for failed tests to give helpful information:
UPDATE tests
SET message = 'Result for ' || tests.number || ' is ' || actual.steps || ', but should be ' || tests.expected
FROM (SELECT number, steps FROM collatz) AS actual
WHERE actual.number = tests.number AND tests.status = 'fail';

-- Save results to ./output.json (needed by the online test-runner)
.mode json
.once './output.json'
SELECT description, status, message, output, test_code, task_id
FROM tests;

-- Display test results in readable form for the student:
.mode table
SELECT description, status, message
FROM tests;

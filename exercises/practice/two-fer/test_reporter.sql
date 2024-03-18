UPDATE tests
SET message = 'Result for ' || tests.input || ' is ' || actual.response || ', but should be ' || tests.expected
FROM (SELECT input, response FROM twofer) AS actual
WHERE actual.input = tests.input AND tests.status = 'fail';

-- Save results to ./output.json (needed by the online test-runner)
.mode json
.once './output.json'
SELECT description, status, message, output, test_code, task_id
FROM tests;

-- Display test results in readable form for the student:
.mode table
SELECT description, status, message
FROM tests;

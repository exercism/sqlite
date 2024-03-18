-- Update message for failed tests to give helpful information:
UPDATE tests
SET message = 'Result for "' || tests.input || '" is ' || actual.is_isogram || ', but should be "' || tests.expected || ''
FROM (SELECT phrase, is_isogram FROM isogram) AS actual
WHERE actual.phrase = tests.input AND tests.status = 'fail';

-- Save results to ./output.json (needed by the online test-runner)
.mode json
.once './output.json'
SELECT description, status, message, output, test_code, task_id
FROM tests;

-- Display test results in readable form for the student:
.mode table
SELECT description, status, message
FROM tests;

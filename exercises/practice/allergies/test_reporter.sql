-- Update message for failed tests to give helpful information:
UPDATE tests
SET message = 'Result for ' || tests.task || ' ' || tests.item || ' ' || tests.score || ' is ' || actual.result || ', but should be ' || tests.expected
FROM (SELECT task, item, score, result FROM allergies) AS actual
WHERE (actual.task, actual.item, actual.score) = (tests.task, tests.item, tests.score) AND tests.status = 'fail';

-- Save results to ./output.json (needed by the online test-runner)
.mode json
.once './output.json'
SELECT name, status, message, output, test_code, task_id
FROM tests;

-- Display test results in readable form for the student:
.mode table
SELECT name, status, message
FROM tests;

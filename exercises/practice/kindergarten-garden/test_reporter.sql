-- Update message for failed tests to give helpful information:
UPDATE tests
SET message = (
    'Result for "' || tests.diagram || '" and "' || tests.student || '"'
    || ' is <' || COALESCE(actual.result, 'NULL')
    || '> but should be <' || tests.expected || '>'
)
FROM (SELECT diagram, student, result FROM 'kindergarten-garden') AS actual
WHERE (actual.diagram, actual.student) = (tests.diagram, tests.student) AND tests.status = 'fail';

-- Save results to ./output.json (needed by the online test-runner)
.mode json
.once './output.json'
SELECT name, status, message, output, test_code, task_id
FROM tests;

-- Display test results in readable form for the student:
.mode table
SELECT name, status, message
FROM tests;

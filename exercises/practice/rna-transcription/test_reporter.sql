-- Update message for failed tests to give helpful information:
UPDATE tests
SET message = (
    'Result for "' || tests.dna || '"'
    || ' is <' || COALESCE(actual.result, 'NULL')
    || '> but should be <' || tests.expected || '>'
)
FROM (SELECT dna, result FROM 'rna-transcription') AS actual
WHERE actual.dna = tests.dna AND tests.status = 'fail';

-- Save results to ./output.json (needed by the online test-runner)
.mode json
.once './output.json'
SELECT name, status, message, output, test_code, task_id
FROM tests;

-- Display test results in readable form for the student:
.mode table
SELECT name, status, message
FROM tests;

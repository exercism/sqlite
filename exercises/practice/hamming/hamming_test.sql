-- Create database:
.read ./create_fixture.sql

-- Read user student solution and save any output as markdown in user_output.md:
.mode markdown
.output user_output.md
.read ./hamming.sql
.output

-- Create a clean testing environment:
.read ./create_test_table.sql

-- Comparison of user input and the tests updates the status for each test:
UPDATE tests
SET status = 'pass'
FROM (SELECT strand1, strand2, result FROM hamming) AS actual
WHERE (actual.strand1, actual.strand2, actual.result) = (tests.strand1, tests.strand2, tests.expected);

-- Update message for failed tests to give helpful information:
UPDATE tests
SET message = (
    'Result for "'
    || PRINTF('strand1=''%s'' and strand2=''%s''', actual.strand1, actual.strand2)
    || '"'
    || ' is <' || COALESCE(actual.result, 'NULL')
    || '> but should be <' || tests.expected || '>'
)
FROM (SELECT strand1, strand2, result FROM hamming) AS actual
WHERE (actual.strand1, actual.strand2) = (tests.strand1, tests.strand2) AND tests.status = 'fail';

-- Save results to ./output.json (needed by the online test-runner)
.mode json
.once './output.json'
SELECT description, status, message, output, test_code, task_id
FROM tests;

-- Display test results in readable form for the student:
.mode table
SELECT description, status, message
FROM tests;

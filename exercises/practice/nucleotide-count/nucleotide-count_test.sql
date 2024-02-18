-- Create database:
.read ./create_fixture.sql

-- Read user student solution and save any output as markdown in user_output.md:
.mode markdown
.output user_output.md
.read ./nucleotide-count.sql
.output

-- Create a clean testing environment:
.read ./create_test_table.sql

-- Comparison of user input and the tests updates the status for each test:
UPDATE tests
SET status = 'pass'
FROM (SELECT strand, result FROM nucleotide_count) AS actual
WHERE (actual.strand, actual.result) = (tests.input, tests.expected);

-- Update message for failed tests to give helpful information:
UPDATE tests
SET message = 'Result is ' || actual.result || ', but should be ' || tests.expected
FROM (SELECT strand, result  FROM nucleotide_count) AS actual
WHERE actual.strand = tests.input AND tests.status = 'fail';

-- Process test cases that should fail:
-- All error tests should pass, updated to fail if invalid entry is possible
UPDATE tests
SET status = 'pass'
WHERE expected = 'error';

-- Only triggered if insert is successful
CREATE TRIGGER IF NOT EXISTS error_checker 
    AFTER INSERT
    ON nucleotide_count
BEGIN
    UPDATE tests
    SET status = 'fail',
        message = NEW.strand || ' should be restricted from insertion'
    WHERE tests.input = NEW.strand;
END;

INSERT OR IGNORE INTO nucleotide_count (strand)
SELECT input FROM tests
WHERE expected = 'error';

-- Save results to ./output.json (needed by the online test-runner)
.mode json
.once './output.json'
SELECT name, status, message, output, test_code, task_id
FROM tests;

-- Display test results in readable form for the student:
.mode table
SELECT name, status, message
FROM tests;

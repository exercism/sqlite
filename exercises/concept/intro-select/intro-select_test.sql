-- Create database:
.read ./create_fixture.sql
-- Read user student solution and save any output as markdown in user_output.md:
.mode markdown
.output user_output.md
.echo on  
.read ./intro-select.sql
.echo off
.output
.shell sed -i 1d user_output.md

-- Re-run stub file to collect the results as json arrays
.mode json
.output outputs.txt
.read ./intro-select.sql
.output
-- Creating the results table from the outputs.txt file
DROP TABLE IF EXISTS outputs;
CREATE TEMPORARY TABLE outputs (line TEXT NOT NULL);
.mode tabs
.import ./outputs.txt outputs
DROP TABLE IF EXISTS results;
CREATE TABLE results (result TEXT NOT NULL);
WITH inputs (input) AS (
  SELECT JSON(PRINTF('[%s]', GROUP_CONCAT(RTRIM(TRIM(line), ','), ',')))
    FROM outputs
)
INSERT INTO results (result)
SELECT j.value
  FROM inputs, JSON_EACH(input) j
;

-- Create a clean testing environment:
.read ./create_test_table.sql
-- Comparison of user input and the tests updates the status for each test:
UPDATE tests
   SET status = 'pass'
  FROM (SELECT result FROM results) AS actual
 WHERE NOT EXISTS (
   SELECT key, value, type, path
     FROM JSON_TREE(result)
    WHERE type NOT IN ('array', 'object')
   EXCEPT
   SELECT key, value, type, path
     FROM JSON_TREE(expected)
    WHERE type NOT IN ('array', 'object')
 )
  AND NOT EXISTS (
    SELECT key, value, type, path
      FROM JSON_TREE(expected)
     WHERE type NOT IN ('array', 'object')
    EXCEPT
    SELECT key, value, type, path
      FROM JSON_TREE(result)
     WHERE type NOT IN ('array', 'object')
  )
;

-- Update message for failed tests to give helpful information:
UPDATE tests
  -- SET message = 'Result for "' || tests.description || '"' || ' is <' || COALESCE(actual.result, 'NULL') || '> but should be <' || tests.expected || '>'
  SET message = 'Result for <"' || tests.description || '">' || ' NOT FOUND' -- need improvements
WHERE tests.status = 'fail';

-- Save results to ./output.json (needed by the online test-runner)
.mode json
.once './output.json'
SELECT
  description,
  status,
  message,
  output,
  test_code,
  task_id
FROM
  tests;

-- Display test results in readable form for the student:
.mode table
SELECT
  description,
  status,
  message
FROM
  tests;

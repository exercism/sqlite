-- Create database:
.read ./create_fixture.sql

-- Read user student solution and save any output as markdown in user_output.md:
.mode markdown
.output user_output.md
.read ./word-search.sql
.output

-- Create a clean testing environment:
.read ./create_test_table.sql

-- Comparison of user input and the tests updates the status for each test:
UPDATE tests
   SET status = 'pass'
  FROM (SELECT input, result FROM "word-search") AS actual
 WHERE actual.input = tests.input
  AND (SELECT
         NOT EXISTS (
           SELECT j.key, j.value FROM JSON_EACH(actual.result) j
           EXCEPT
           SELECT j.key, j.value FROM JSON_EACH(tests.expected) j
         ) AND NOT EXISTS (
           SELECT j.key, j.value FROM JSON_EACH(tests.expected) j
           EXCEPT
           SELECT j.key, j.value FROM JSON_EACH(actual.result) j
         )
      )
  ;

-- Update message for failed tests to give helpful information:
UPDATE tests
   SET message = (
        'Result for "' || tests.input || '"' || ' is <' ||
         COALESCE(actual.result, 'NULL') || '> but should be <' ||
         tests.expected || '>'
       )
  FROM (SELECT input, result FROM "word-search") AS actual
 WHERE actual.input = tests.input
   AND tests.status = 'fail'
;

-- Hacking errors ---------------------------------------------
INSERT INTO tests (uuid, description, input, expected, message)
VALUES ('a', '', '', '', (SELECT COUNT(*) 'COUNT string on strings table' FROM strings WHERE INSTR(string, 'java')));
---------------------------------------------------------------

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

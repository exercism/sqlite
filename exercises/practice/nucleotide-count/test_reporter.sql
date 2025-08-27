-- Update message for failed tests to give helpful information:
UPDATE tests
SET
  message = (
    'Result for "' || tests.input || '"' || ' is <' || COALESCE(actual.result, 'NULL') || '> but should be <' || tests.expected || '>'
  )
FROM
  (
    SELECT
      strand,
      result
    FROM
      "nucleotide-count"
  ) AS actual
WHERE
  actual.strand = tests.input
  AND tests.status = 'fail';

-- Process test cases that should fail:
-- All error tests should pass, updated to fail if invalid entry is possible
UPDATE tests
SET
  status = 'pass'
WHERE
  expected = 'error';

-- Only triggered if insert is successful
CREATE TRIGGER IF NOT EXISTS error_checker AFTER INSERT ON "nucleotide-count" BEGIN
UPDATE tests
SET
  status = 'fail',
  message = NEW.strand || ' should be restricted from insertion'
WHERE
  tests.input = NEW.strand;

END;

INSERT OR IGNORE INTO
  "nucleotide-count" (strand)
SELECT
  input
FROM
  tests
WHERE
  expected = 'error';

-- Save results to ./output.json (needed by the online test-runner)
.mode json
.once './output.json'
SELECT
  name,
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
  name,
  status,
  message
FROM
  tests;

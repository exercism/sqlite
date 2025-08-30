-- Setup test table and read in student solution:
.read ./test_setup.sql
-- Test cases:
INSERT INTO
  tests (name, uuid, input, expected)
VALUES
  (
    'empty strand',
    '3e5c30a8-87e2-4845-a815-a49671ade970',
    '',
    json(' { "A": 0, "C": 0, "G": 0, "T": 0 } ')
  ),
  (
    'can count one nucleotide in single-character input',
    'a0ea42a6-06d9-4ac6-828c-7ccaccf98fec',
    'G',
    json(' { "A": 0, "C": 0, "G": 1, "T": 0 } ')
  ),
  (
    'strand with repeated nucleotide',
    'eca0d565-ed8c-43e7-9033-6cefbf5115b5',
    'GGGGGGG',
    json(' { "A": 0, "C": 0, "G": 7, "T": 0 } ')
  ),
  (
    'strand with multiple nucleotides',
    '40a45eac-c83f-4740-901a-20b22d15a39f',
    'AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC',
    json(' { "A": 20, "C": 12, "G": 17, "T": 21 } ')
  ),
  -- The following case is tested by inserting the input into the "nucleotide-count" table.
  -- The test only succeeds, if the input is blocked from being inserted to the table by a check condition or some similar construct.
  (
    'strand with invalid nucleotides',
    'b4c47851-ee9e-4b0a-be70-a86e343bd851',
    'AGXXACT',
    'error'
  );

-- Comparison of user input and the tests updates the status for each test:
UPDATE tests
SET
  status = 'pass'
FROM
  (
    SELECT
      strand,
      result
    FROM
      "nucleotide-count"
  ) AS actual
WHERE
  (actual.strand, actual.result) = (tests.input, tests.expected);

-- Write results and debug info:
.read ./test_reporter.sql

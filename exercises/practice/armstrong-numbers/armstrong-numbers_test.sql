-- Setup test table and read in student solution:
.read ./test_setup.sql
-- Test cases:
-- Note: the strings below _may_ contain literal tab, newline, or carriage returns.
INSERT INTO
  tests (name, uuid, number, expected)
VALUES
  (
    'Zero is an Armstrong number',
    'c1ed103c-258d-45b2-be73-d8c6d9580c7b',
    0,
    true
  ),
  (
    'Single-digit numbers are Armstrong numbers',
    '579e8f03-9659-4b85-a1a2-d64350f6b17a',
    5,
    true
  ),
  (
    'There are no two-digit Armstrong numbers',
    '2d6db9dc-5bf8-4976-a90b-b2c2b9feba60',
    10,
    false
  ),
  (
    'Three-digit number that is an Armstrong number',
    '509c087f-e327-4113-a7d2-26a4e9d18283',
    153,
    true
  ),
  (
    'Three-digit number that is not an Armstrong number',
    '7154547d-c2ce-468d-b214-4cb953b870cf',
    100,
    false
  ),
  (
    'Four-digit number that is an Armstrong number',
    '6bac5b7b-42e9-4ecb-a8b0-4832229aa103',
    9474,
    true
  ),
  (
    'Four-digit number that is not an Armstrong number',
    'eed4b331-af80-45b5-a80b-19c9ea444b2e',
    9475,
    false
  ),
  (
    'Seven-digit number that is an Armstrong number',
    'f971ced7-8d68-4758-aea1-d4194900b864',
    9926315,
    true
  ),
  (
    'Seven-digit number that is not an Armstrong number',
    '7ee45d52-5d35-4fbd-b6f1-5c8cd8a67f18',
    9926314,
    false
  );

-- Comparison of user input and the tests updates the status for each test:
UPDATE tests
SET
  status = 'pass'
FROM
  (
    SELECT
      number,
      result
    FROM
      "armstrong-numbers"
  ) AS actual
WHERE
  (actual.number, actual.result) = (tests.number, tests.expected);

-- Write results and debug info:
.read ./test_reporter.sql

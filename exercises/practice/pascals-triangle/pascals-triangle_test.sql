-- Setup test table and read in student solution:
.read ./test_setup.sql
-- Test cases:
INSERT INTO
  tests (name, uuid, input, expected)
VALUES
  (
    'zero rows',
    '9920ce55-9629-46d5-85d6-4201f4a4234d',
    0,
    ''
  ),
  (
    'single row',
    '70d643ce-a46d-4e93-af58-12d88dd01f21',
    1,
    '1'
  ),
  (
    'two rows',
    'a6e5a2a2-fc9a-4b47-9f4f-ed9ad9fbe4bd',
    2,
    '1
1 1'
  ),
  (
    'three rows',
    '97206a99-79ba-4b04-b1c5-3c0fa1e16925',
    3,
    '1
1 1
1 2 1'
  ),
  (
    'four rows',
    '565a0431-c797-417c-a2c8-2935e01ce306',
    4,
    '1
1 1
1 2 1
1 3 3 1'
  ),
  (
    'five rows',
    '06f9ea50-9f51-4eb2-b9a9-c00975686c27',
    5,
    '1
1 1
1 2 1
1 3 3 1
1 4 6 4 1'
  ),
  (
    'six rows',
    'c3912965-ddb4-46a9-848e-3363e6b00b13',
    6,
    '1
1 1
1 2 1
1 3 3 1
1 4 6 4 1
1 5 10 10 5 1'
  ),
  (
    'ten rows',
    '6cb26c66-7b57-4161-962c-81ec8c99f16b',
    10,
    '1
1 1
1 2 1
1 3 3 1
1 4 6 4 1
1 5 10 10 5 1
1 6 15 20 15 6 1
1 7 21 35 35 21 7 1
1 8 28 56 70 56 28 8 1
1 9 36 84 126 126 84 36 9 1'
  );

-- Comparison of user input and the tests updates the status for each test:
UPDATE tests
SET
  status = 'pass'
FROM
  (
    SELECT
      input,
      result
    FROM
      "pascals-triangle"
  ) AS actual
WHERE
  (actual.input, actual.result) = (tests.input, tests.expected);

-- Write results and debug info:
.read ./test_reporter.sql

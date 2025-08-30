UPDATE "perfect-numbers"
SET
  error = 'Classification is only possible for positive integers.'
WHERE
  number < 1;

UPDATE "perfect-numbers"
SET
  result = 'deficient'
WHERE
  number = 1
  AND error ISNULL;

UPDATE "perfect-numbers"
SET
  result = (
    WITH
      factors AS (
        SELECT
          IIF(number % value = 0, value, 0) divisor
        FROM
          GENERATE_SERIES (1, number / 2)
      ),
      aliquot_sums AS (
        SELECT
          SUM(divisor) aliquot_sum
        FROM
          factors
      )
    SELECT
      CASE
        WHEN number = aliquot_sum THEN 'perfect'
        WHEN number < aliquot_sum THEN 'abundant'
        WHEN number > aliquot_sum THEN 'deficient'
      END
    FROM
      aliquot_sums
  )
WHERE
  error ISNULL
  AND result ISNULL;

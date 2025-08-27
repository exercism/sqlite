UPDATE "eliuds-eggs"
SET
  result = 0;

UPDATE "eliuds-eggs"
SET
  result = counter
FROM
  (
    WITH RECURSIVE
      powers_of_two (x) AS (
        SELECT
          1
        UNION ALL
        SELECT
          x * 2
        FROM
          powers_of_two
        WHERE
          x <= (
            SELECT
              MAX(number)
            FROM
              "eliuds-eggs"
          )
      )
    SELECT
      number,
      sum(number / (x / 2) % 2) as counter
    FROM
      powers_of_two,
      "eliuds-eggs"
    WHERE
      x <= 2 * number
    GROUP BY
      number
  ) AS calculation
WHERE
  calculation.number = "eliuds-eggs".number;

UPDATE "largest-series-product"
SET
  error = 'span must not exceed string length'
WHERE
  LENGTH(digits) < span;

UPDATE "largest-series-product"
SET
  error = 'digits input must only contain digits'
WHERE
  GLOB('*[^0-9]*', digits);

UPDATE "largest-series-product"
SET
  error = 'span must not be negative'
WHERE
  span < 0;

UPDATE "largest-series-product"
SET
  result = 1
WHERE
  span = 0;

UPDATE "largest-series-product"
SET
  result = (
    WITH RECURSIVE
      split_series (string, serie, product) AS (
        VALUES
          (digits, NULL, NULL)
        UNION ALL
        SELECT
          SUBSTR(string, 2),
          SUBSTR(string, 1, span),
          (
            WITH RECURSIVE
              split_digits (serie, digit) AS (
                VALUES
                  (SUBSTR(string, 1, span), NULL)
                UNION ALL
                SELECT
                  SUBSTR(serie, 2),
                  SUBSTR(serie, 1, 1) * 1
                FROM
                  split_digits
                WHERE
                  serie <> ''
              )
            SELECT
              IIF(
                (
                  SELECT
                    1
                  FROM
                    split_digits
                  WHERE
                    digit = 0
                ),
                0,
                EXP(SUM(LN(digit)))
              ) AS product
            FROM
              split_digits
            WHERE
              digit NOTNULL
          )
        FROM
          split_series
        WHERE
          string <> ''
      )
    SELECT
      ROUND(MAX(product))
    FROM
      split_series
    WHERE
      LENGTH(serie) = span
  )
WHERE
  error ISNULL
  AND result ISNULL;

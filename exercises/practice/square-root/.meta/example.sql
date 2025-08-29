UPDATE "square-root"
SET
  result = (
    WITH RECURSIVE
      isqrt (number, approx) AS (
        VALUES
          (radicand, radicand)
        UNION ALL
        SELECT
          number,
          (number / approx + approx) / 2
        FROM
          isqrt
        WHERE
          approx * approx != NUMBER
          AND approx > 1
      )
    SELECT
      approx AS sqrt
    FROM
      isqrt
    ORDER BY
      approx ASC
    LIMIT
      1
  );

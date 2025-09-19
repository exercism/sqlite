WITH results ("limit", primes) AS (
SELECT
  "limit",
  (WITH
     cte AS (
       SELECT (SELECT JSON_GROUP_ARRAY(JSON_ARRAY(g.value, NULL))
                 FROM GENERATE_SERIES(2, "limit") g) numbers
     )
  SELECT
    (WITH RECURSIVE rcte (matrix) AS (
      VALUES (numbers)
      UNION ALL
      SELECT
      (WITH first_unmarked (prime) AS (
        SELECT JSON_EXTRACT(value, '$[0]')
          FROM JSON_EACH(matrix)
         WHERE JSON_EXTRACT(value, '$[1]') ISNULL
         LIMIT 1
      )
      SELECT
        JSON_GROUP_ARRAY(
          CASE
          WHEN JSON_EXTRACT(j.value, '$[0]') = prime
            THEN   JSON_SET(j.value, '$[1]', JSON('true'))
          WHEN JSON_EXTRACT(j.value, '$[1]') ISNULL AND
               JSON_EXTRACT(j.value, '$[0]') % prime = 0
            THEN   JSON_SET(j.value, '$[1]', JSON('false'))
          ELSE j.value
          END
        )
        FROM first_unmarked, JSON_EACH(matrix) j
      )
      FROM rcte
      WHERE (SELECT 1
               FROM JSON_EACH(matrix)
              WHERE JSON_EXTRACT(value, '$[1]') ISNULL)
    )
    SELECT COALESCE(GROUP_CONCAT(JSON_EXTRACT(j.value, '$[0]'), ', '), '')
      FROM rcte, JSON_EACH(matrix) j
     WHERE (SELECT COUNT(*) = 0
              FROM JSON_EACH(matrix)
             WHERE JSON_EXTRACT(value, '$[1]') ISNULL)
       AND JSON_EXTRACT(j.value, '$[1]')
    )
    FROM cte
  )
  FROM sieve
)
UPDATE sieve
   SET result = primes
  FROM results
 WHERE sieve."limit" = results."limit"
;

WITH
  working AS (
    SELECT
      x,
      y,
      SQRT(POWER(x, 2) + POWER(y, 2)) as hypotenuse
    FROM
      darts
  )
UPDATE darts
SET
  score = CASE
    WHEN hypotenuse <= 1 THEN 10
    WHEN hypotenuse <= 5 THEN 5
    WHEN hypotenuse <= 10 THEN 1
    ELSE 0
  END
FROM
  working
WHERE
  (darts.x, darts.y) = (working.x, working.y);

UPDATE "pascals-triangle"
SET
  result = (
    WITH RECURSIVE
      counter (k) AS (
        SELECT
          1
        UNION ALL
        SELECT
          k + 1
        FROM
          counter
        WHERE
          k < input
      )
    SELECT
      group_concat(
        (
          WITH RECURSIVE
            nums (idx, s) AS (
              SELECT
                1,
                1
              UNION ALL
              SELECT
                idx + 1,
                s * k / idx - s
              FROM
                nums
              WHERE
                idx < k
            )
          SELECT
            group_concat(s, ' ')
          FROM
            nums
        ),
        char(10) -- newline
      )
    FROM
      counter
  );

UPDATE "pascals-triangle"
SET
  result = ''
WHERE
  input = 0;

UPDATE "queen-attack"
   SET error =
       CASE
       WHEN white_row < 0 OR black_row < 0 THEN 'row not positive'
       WHEN white_row > 7 OR black_row > 7 THEN 'row not on board'
       WHEN white_col < 0 OR black_col < 0 THEN 'column not positive'
       WHEN white_col > 7 OR black_col > 7 THEN 'column not on board'
       END
;

UPDATE "queen-attack"
   SET result = (
     WITH
       seq AS (SELECT value FROM GENERATE_SERIES(0, 7)),
       positions (row, col) AS (
       SELECT white_row, value FROM seq
        UNION
       SELECT value, white_col FROM seq
        UNION
       SELECT white_row - value AS r, white_col - value AS c
         FROM seq
        WHERE r >= 0 AND c >= 0
        UNION
       SELECT white_row + value AS r, white_col + value AS c
         FROM seq
        WHERE r <= 7 AND c <= 7
        UNION
       SELECT white_row - value AS r, white_col - value AS c
         FROM seq
        WHERE r >= 0 AND c >= 0
        UNION
       SELECT white_row + value AS r, white_col + value AS c
         FROM seq
        WHERE r <= 7 AND c <= 7
        UNION
       SELECT white_row + value AS r, white_col - value AS c
         FROM seq
        WHERE r <= 7 AND c >= 0
        UNION
       SELECT white_row - value AS r, white_col + value AS c
         FROM seq
        WHERE r >= 0 AND c <= 7
     )
     SELECT
       COALESCE(
         (SELECT TRUE
            FROM positions
           WHERE row = black_row
             AND col = black_col
         ),
         FALSE
       )
   )
 WHERE error ISNULL
;

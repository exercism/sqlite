WITH
  cte AS (
    SELECT input,
           JSON_EXTRACT(input, '$.queen.position.row')    AS row,
           JSON_EXTRACT(input, '$.queen.position.column') AS col
      FROM "queen-attack"
     WHERE property = 'create'
  ),
  errors AS (
    SELECT input,
           CASE
           WHEN row < 0 THEN 'row not positive'
           WHEN row > 7 THEN 'row not on board'
           WHEN col < 0 THEN 'column not positive'
           WHEN col > 7 THEN 'column not on board'
           END AS error
      FROM cte
     WHERE error NOT NULL
  )
    UPDATE "queen-attack"
    SET error = errors.error
    FROM errors
    WHERE "queen-attack".input = errors.input
    ;

UPDATE "queen-attack"
   SET result = TRUE
 WHERE error ISNULL
   AND property = 'create'
       ;

UPDATE "queen-attack"
   SET result = (
     WITH positions (row, col) AS (
       WITH cte (row, col) AS (
         VALUES (
           JSON_EXTRACT(input, '$.white_queen.position.row'),
           JSON_EXTRACT(input, '$.white_queen.position.column')
         )
       )
       SELECT row, value FROM cte, generate_series(0, 7)
        UNION
       SELECT value, col FROM cte, generate_series(0, 7)
        UNION
       SELECT row - value AS r, col - value AS c
         FROM cte, GENERATE_SERIES(0, 7)
        WHERE r >= 0 AND c >= 0
        UNION
       SELECT row + value AS r, col + value AS c
         FROM cte, GENERATE_SERIES(0, 7)
        WHERE r <= 7 AND c <= 7
        UNION
       SELECT row - value AS r, col - value AS c
         FROM cte, GENERATE_SERIES(0, 7)
        WHERE r >= 0 AND c >= 0
        UNION
       SELECT row + value AS r, col + value AS c
         FROM cte, GENERATE_SERIES(0, 7)
        WHERE r <= 7 AND c <= 7
        UNION
       SELECT row + value AS r, col - value AS c
         FROM cte, GENERATE_SERIES(0, 7)
        WHERE r <= 7 AND c >= 0
        UNION
       SELECT row - value AS r, col + value AS c
         FROM cte, GENERATE_SERIES(0, 7)
        WHERE r >= 0 AND c <= 7
     )
     SELECT
       COALESCE(
         (SELECT TRUE
            FROM positions
           WHERE row = JSON_EXTRACT(input, '$.black_queen.position.row')
             AND col = JSON_EXTRACT(input, '$.black_queen.position.column')
         ),
         FALSE
       )
   )
 WHERE property = 'canAttack'
;

UPDATE series
   SET error = 'slice length cannot be zero'
 WHERE slice_length = 0
   AND error ISNULL
;
UPDATE series
   SET error = 'series cannot be empty'
 WHERE input = ''
   AND error ISNULL
;
UPDATE series
   SET error = 'slice length cannot be greater than series length'
 WHERE slice_length > LENGTH(input)
   AND error ISNULL
;
UPDATE series
   SET error = 'slice length cannot be negative'
 WHERE slice_length < 0
   AND error ISNULL
;

UPDATE series
   SET result = (
     WITH RECURSIVE to_series (digits, serie) AS (
       VALUES (input, NULL)
       UNION ALL
       SELECT SUBSTR(digits, 2), SUBSTR(digits, 1, slice_length)
         FROM to_series
        WHERE digits <> ''
     )
     SELECT GROUP_CONCAT(serie, CHAR(10)) AS series
       FROM to_series WHERE LENGTH(serie) = slice_length
   )
 WHERE error ISNULL
;

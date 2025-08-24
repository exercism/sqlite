UPDATE proverb
   SET result = ''
 WHERE JSON(strings) = '[]'
;

UPDATE proverb
   SET result = (
     WITH RECURSIVE to_pieces (strings, i, len, piece) AS (
       VALUES(strings, 0, JSON_ARRAY_LENGTH(strings) - 1, NULL)
       UNION ALL
       SELECT strings, i+1, len,
              PRINTF(
                'For want of a %s the %s was lost.',
                JSON_EXTRACT(strings, PRINTF('$[%d]', i)),
                JSON_EXTRACT(strings, PRINTF('$[%d]', i+1))
              )
         FROM to_pieces
        WHERE i < len
     )
     SELECT group_concat(piece, CHAR(10))
       FROM (
         SELECT piece
           FROM to_pieces
          WHERE piece NOTNULL
          UNION ALL
         SELECT PRINTF(
                  'And all for the want of a %s.',
                  JSON_EXTRACT(strings, '$[0]')
                )
       )
   )
 WHERE result ISNULL
;

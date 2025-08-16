DROP TABLE IF EXISTS inputs;
CREATE TEMPORARY TABLE inputs (
    idx     INTEGER NOT NULL,
    ordinal TEXT    NOT NULL,
    item    TEXT    NOT NULL
);
INSERT INTO inputs (idx, ordinal, item)
VALUES
( 1, 'first',    'a Partridge in a Pear Tree'),
( 2, 'second',   'two Turtle Doves'          ),
( 3, 'third',    'three French Hens'         ),
( 4, 'fourth',   'four Calling Birds'        ),
( 5, 'fifth',    'five Gold Rings'           ),
( 6, 'sixth',    'six Geese-a-Laying'        ),
( 7, 'seventh',  'seven Swans-a-Swimming'    ),
( 8, 'eighth',   'eight Maids-a-Milking'     ),
( 9, 'ninth',    'nine Ladies Dancing'       ),
(10, 'tenth',    'ten Lords-a-Leaping'       ),
(11, 'eleventh', 'eleven Pipers Piping'      ),
(12, 'twelfth',  'twelve Drummers Drumming'  );

DROP TABLE IF EXISTS verses;
CREATE TEMPORARY TABLE verses AS
  SELECT idx,
         PRINTF(
           'On the %s day of Christmas my true love gave to me: %s.',
           ordinal,
           items
         ) AS verse
  FROM (
    SELECT
      idx, ordinal,
      GROUP_CONCAT(item, IIF(idx = 1, ', and ', ', '))
        OVER(
          ORDER BY idx DESC ROWS BETWEEN 0 PRECEDING AND 12 FOLLOWING
        ) items
      FROM inputs
     ORDER BY idx
  )
;

UPDATE "twelve-days"
   SET result = (
     SELECT GROUP_CONCAT(verse, CHAR(10))
       FROM (
         SELECT verse
           FROM verses
          WHERE idx BETWEEN start_verse AND end_verse
          ORDER BY idx
       )
   )
;

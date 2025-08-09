DROP TABLE IF EXISTS pairs;
CREATE TEMPORARY TABLE pairs (
  n INTEGER NOT NULL,
  a TEXT NOT NULL,
  b TEXT NOT NULL
);
INSERT INTO pairs (n, a, b)
VALUES
(10, 'Ten'  , 'Nine' ),
( 9, 'Nine' , 'Eight'),
( 8, 'Eight', 'Seven'),
( 7, 'Seven', 'Six'  ),
( 6, 'Six'  , 'Five' ),
( 5, 'Five' , 'Four' ),
( 4, 'Four' , 'Three'),
( 3, 'Three', 'Two'  ),
( 2, 'Two'  , 'One'  ),
( 1, 'One'  , 'no'   );

DROP TABLE IF EXISTS verses;
CREATE TABLE verses AS
  SELECT n,
         FORMAT('%s green bottles hanging on the wall,' || CHAR(10), a) ||
         FORMAT('%s green bottles hanging on the wall,' || CHAR(10), a) ||
         'And if one green bottle should accidentally fall,' || CHAR(10) ||
         FORMAT(
           'There''ll be %s green bottles hanging on the wall.',
           LOWER(b)
         ) AS verse
  FROM pairs
;

UPDATE verses
   SET verse = REPLACE(verse, 'be one green bottles', 'be one green bottle')
 WHERE n = 2;
UPDATE verses
   SET verse = REPLACE(verse, 'One green bottles', 'One green bottle')
 WHERE n = 1;


UPDATE "bottle-song"
   SET result = (
     SELECT GROUP_CONCAT(verse, CHAR(10)||CHAR(10))
       FROM (
         SELECT verse
           FROM verses
          WHERE n <= start_bottles
            AND n > start_bottles - take_down
          ORDER BY n DESC
       )
   )
;

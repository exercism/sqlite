DROP TABLE IF EXISTS verses;
CREATE TEMPORARY TABLE verses AS
WITH cte (idx, sentence) AS (
  VALUES
  ( 1, 'in the house that Jack built'                          ),
  ( 2, 'malt that lay'                                         ),
  ( 3, 'rat that ate the'                                      ),
  ( 4, 'cat that killed the'                                   ),
  ( 5, 'dog that worried the'                                  ),
  ( 6, 'cow with the crumpled horn that tossed the'            ),
  ( 7, 'maiden all forlorn that milked the'                    ),
  ( 8, 'man all tattered and torn that kissed the'             ),
  ( 9, 'priest all shaven and shorn that married the'          ),
  (10, 'rooster that crowed in the morn that woke the'         ),
  (11, 'farmer sowing his corn that kept the'                  ),
  (12, 'horse and the hound and the horn that belonged to the' )
)
SELECT idx,
       IIF(idx = 1, REPLACE(verse, ' the in the ', ' the '), verse) AS verse
  FROM (
    SELECT idx,
           PRINTF(
             'This is the %s.',
             GROUP_CONCAT(sentence, ' ')
             OVER (ORDER BY idx DESC ROWS BETWEEN 0 PRECEDING AND 12 FOLLOWING)
           ) AS verse
      FROM cte
     ORDER BY idx ASC
  )
;

UPDATE house
   SET result = (
     SELECT GROUP_CONCAT(verse, CHAR(10))
       FROM verses
      WHERE idx BETWEEN start_verse AND end_verse
   )
;

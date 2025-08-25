UPDATE say SET result = 'zero' WHERE number = 0;

UPDATE say
   SET error = 'input out of range'
 WHERE number < 0
    OR number >= 1e12
;

DROP TABLE IF EXISTS dict;
CREATE TEMPORARY TABLE dict (
  digits INTEGER PRIMARY KEY,
  words  TEXT    NOT NULL
);
INSERT INTO dict (digits, words)
VALUES ( 0, 'zero'     ),
       ( 1, 'one'      ),
       ( 2, 'two'      ),
       ( 3, 'three'    ),
       ( 4, 'four'     ),
       ( 5, 'five'     ),
       ( 6, 'six'      ),
       ( 7, 'seven'    ),
       ( 8, 'eight'    ),
       ( 9, 'nine'     ),
       (10, 'ten'      ),
       (11, 'eleven'   ),
       (12, 'twelve'   ),
       (13, 'thirteen' ),
       (14, 'fourteen' ),
       (15, 'fifteen'  ),
       (16, 'sixteen'  ),
       (17, 'seventeen'),
       (18, 'eighteen' ),
       (19, 'nineteen' ),
       (20, 'twenty'   ),
       (30, 'thirty'   ),
       (40, 'forty'    ),
       (50, 'fifty'    ),
       (60, 'sixty'    ),
       (70, 'seventy'  ),
       (80, 'eighty'   ),
       (90, 'ninety'   );
WITH dozens (jarray) AS (
  SELECT (
    WITH RECURSIVE rcte (base, unit, dozen, string) AS (
      VALUES (digits, 1, NULL, NULL)
      UNION ALL
      SELECT digits,
             unit + 1,
             base + unit,
             PRINTF(
               '%s-%s',
               (SELECT words FROM dict WHERE digits = base),
               (SELECT words FROM dict WHERE digits = unit))
        FROM rcte
       WHERE unit < 10
    )
    SELECT JSON_GROUP_ARRAY(JSON_ARRAY(dozen, string))
      FROM rcte
     WHERE dozen NOT NULL
  )
    FROM dict
   WHERE digits BETWEEN 20 AND 90
)
INSERT INTO dict (digits, words)
SELECT JSON_EXTRACT(j.VALUE, '$[0]'), JSON_EXTRACT(j.VALUE, '$[1]')
  FROM dozens, JSON_EACH(jarray) j;
INSERT INTO dict
SELECT value * 100,
       (SELECT words FROM dict WHERE digits = VALUE) || ' hundred'
  FROM GENERATE_SERIES(1, 9);

DROP TABLE IF EXISTS positions;
CREATE TEMPORARY TABLE positions (
  pos   INTEGER PRIMARY KEY,
  words TEXT    NOT NULL
);
INSERT INTO positions (pos, words)
VALUES ( 2, 'thousand'         ),
       ( 3, 'million'          ),
       ( 4, 'billion'          ),
       ( 5, 'trillion'         ),
       ( 6, 'quadrillion'      ),
       ( 7, 'quintillion'      ),
       ( 8, 'sextillion'       ),
       ( 9, 'septillion'       ),
       (10, 'octillion'        ),
       (11, 'nonillion'        ),
       (12, 'decillion'        ),
       (13, 'undecillion'      ),
       (14, 'duodecillion'     ),
       (15, 'tredecillion'     ),
       (16, 'quattuordecillion'),
       (17, 'quindecillion'    ),
       (18, 'sexdecillion'     ),
       (19, 'septendecillion'  ),
       (20, 'octodecillion'    ),
       (21, 'novemdecillion'   ),
       (22, 'vigintillion'     );

UPDATE say
   SET result = (
     WITH
       decompositor (num, thousands, thpos) AS (
         WITH RECURSIVE decompositor (num, thousands, thpos) AS (
           VALUES (number, NULL, 0)
           UNION ALL
           SELECT num / 1000,
                  JSON_ARRAY( num % 1000 - num % 100, (num % 1000) % 100 ),
                  thpos + 1
             FROM decompositor
            WHERE num > 0
         )
         SELECT * FROM decompositor
       ),
       to_strings (thpos, hundred, dozen, pos_str) AS (
         SELECT
           thpos,
           (
             SELECT words
               FROM dict
              WHERE digits = NULLIF(JSON_EXTRACT(thousands, '$[0]'), 0)
           ),
           (
             SELECT words
               FROM dict
              WHERE digits = NULLIF(JSON_EXTRACT(thousands, '$[1]'), 0 )
           ),
           IIF(
             JSON_EXTRACT(thousands, '$[0]') +
             JSON_EXTRACT(thousands, '$[1]') > 0,
             (SELECT words FROM positions WHERE pos = thpos),
             NULL
           )
           FROM decompositor
          WHERE thpos > 0
       ),
       to_format (thpos, string) AS (
         SELECT thpos, TRIM(PRINTF('%s %s %s', hundred, dozen, pos_str))
           FROM to_strings
          ORDER BY thpos DESC
       )
     SELECT TRIM(GROUP_CONCAT(string, ' ')) FROM to_format
   )
 WHERE error IS NULL
   AND number > 0
;

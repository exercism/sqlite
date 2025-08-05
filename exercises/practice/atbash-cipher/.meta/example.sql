UPDATE "atbash-cipher"
   SET result = (
     WITH RECURSIVE rcte (i, c, string) AS (
       VALUES(1, NULL, (
         WITH RECURSIVE encode (phrase, c) AS (
           VALUES(LOWER(phrase), NULL)
           UNION ALL
           SELECT SUBSTR(phrase, 2), SUBSTR(phrase, 1, 1)
           FROM encode
           WHERE phrase <> ''
         )
         SELECT GROUP_CONCAT(c, '') AS result
           FROM (
             SELECT CASE
                    WHEN (UNICODE(c) BETWEEN UNICODE('a') AND UNICODE('z'))
                      THEN CHAR(UNICODE('z') - (UNICODE(c) - UNICODE('a')))
                    WHEN (UNICODE(c) BETWEEN UNICODE('0') AND UNICODE('9'))
                      THEN c
                    END AS c
               FROM encode
           )
          WHERE c NOT NULL
       ))
       UNION ALL
       SELECT i + 1,
       SUBSTR(string, 1, 1) || IIF(i % 5 = 0, ' ', ''),
       SUBSTR(string, 2)
       FROM rcte
       WHERE string <> ''
     )
     SELECT TRIM(GROUP_CONCAT(c, '')) FROM rcte
   )
 WHERE property = 'encode'
       ;

UPDATE "atbash-cipher"
   SET result = (
     WITH RECURSIVE decode (phrase, c) AS (
       VALUES(phrase, NULL)
       UNION ALL
       SELECT SUBSTR(phrase, 2), SUBSTR(phrase, 1, 1)
       FROM decode
       WHERE phrase <> ''
     )
     SELECT GROUP_CONCAT(c, '') AS result
       FROM (
         SELECT CASE
                WHEN (UNICODE(c) BETWEEN UNICODE('a') AND UNICODE('z'))
                  THEN CHAR(UNICODE('z') - UNICODE(c) + UNICODE('a'))
                WHEN (UNICODE(c) BETWEEN UNICODE('0') AND UNICODE('9')) THEN c
                END AS c
           FROM decode
       )
      WHERE c NOT NULL
   )
 WHERE property = 'decode'
       ;

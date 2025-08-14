UPDATE "word-count"
   SET result = (
     WITH RECURSIVE to_words (string, word) AS (
       VALUES((
         WITH RECURSIVE mark_sep (string, letter) AS (
           VALUES(LOWER(sentence), '')
           UNION ALL
           SELECT SUBSTRING(string, 2), CASE
             WHEN GLOB('[0-9a-z'']', SUBSTRING(string, 1, 1))
             THEN SUBSTRING(string, 1, 1)
             ELSE CHAR(10)
           END
             FROM mark_sep
            WHERE string <> ''
         ) SELECT GROUP_CONCAT(letter, '') || CHAR(10) AS string FROM mark_sep
       ), NULL)
       UNION ALL
       SELECT SUBSTRING(string, INSTR(string, CHAR(10)) + 1),
              TRIM(SUBSTRING(string, 1, INSTR(string, CHAR(10)) - 1), '''')
         FROM to_words
        WHERE string <> ''
     )
     SELECT JSON_GROUP_OBJECT(word, count)
       FROM (
         SELECT word, COUNT(*) count
           FROM to_words
          WHERE word NOT IN ('', CHAR(10))
          GROUP BY word
       )
   );

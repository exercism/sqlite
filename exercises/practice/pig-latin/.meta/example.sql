UPDATE "pig-latin"
SET
  result = (
    WITH
      words (word) AS (
        SELECT
          j.value
        FROM
          JSON_EACH(PRINTF('["%s"]', REPLACE(phrase, ' ', '","'))) j
      )
    SELECT
      GROUP_CONCAT(word, ' ')
    FROM
      (
        SELECT
          (
            WITH
              remove_vowels (word, no_vowel) AS (
                SELECT
                  word,
                  REPLACE(
                    REPLACE(
                      REPLACE(
                        REPLACE(REPLACE(word, 'a', CHAR(10)), 'e', CHAR(10)),
                        'i',
                        CHAR(10)
                      ),
                      'o',
                      CHAR(10)
                    ),
                    'u',
                    CHAR(10)
                  )
                FROM
                  "pig-latin"
              )
            SELECT
              CASE
                WHEN REGEXP ('^([aeiou]|xr|yt)', word) THEN word || 'ay'
                WHEN REGEXP ('^[bcdfghjklmnpqrstvwxyz]*qu', word) THEN PRINTF(
                  '%s%say',
                  SUBSTR(word, INSTR(word, 'qu') + 2),
                  SUBSTR(word, 1, INSTR(word, 'qu') + 1)
                )
                WHEN REGEXP ('^[bcdfghjklmnpqrstvwxz]+y', word) THEN PRINTF(
                  '%s%say',
                  SUBSTR(word, INSTR(word, 'y')),
                  SUBSTR(word, 1, INSTR(word, 'y') - 1)
                )
                WHEN GLOB('[bcdfghjklmnpqrstvwxyz]*', word) THEN PRINTF(
                  '%s%say',
                  SUBSTR(word, INSTR(no_vowel, CHAR(10))),
                  SUBSTR(word, 1, INSTR(no_vowel, CHAR(10)) - 1)
                )
              END
            FROM
              remove_vowels
          ) AS word
        FROM
          words
      )
  );

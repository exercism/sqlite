DROP TABLE IF EXISTS chainmap;

CREATE TEMPORARY TABLE chainmap (
  id INTEGER NOT NULL,
  animal TEXT NOT NULL,
  phrase TEXT NOT NULL
);

INSERT INTO
  chainmap (id, animal, phrase)
VALUES
  (
    1,
    'fly',
    'I don''t know why she swallowed the fly. Perhaps she''ll die.'
  ),
  (
    2,
    'spider',
    'It wriggled and jiggled and tickled inside her.'
  ),
  (3, 'bird', 'How absurd to swallow a bird!'),
  (4, 'cat', 'Imagine that, to swallow a cat!'),
  (5, 'dog', 'What a hog, to swallow a dog!'),
  (
    6,
    'goat',
    'Just opened her throat and swallowed a goat!'
  ),
  (
    7,
    'cow',
    'I don''t know how she swallowed a cow!'
  ),
  (8, 'horse', 'She''s dead, of course!');

DROP TABLE IF EXISTS lyrics;

CREATE TEMPORARY TABLE lyrics (id INTEGER NOT NULL, verse TEXT NOT NULL);

WITH
  verses (id, verse) AS (
    WITH RECURSIVE
      reciter (idx, verses) AS (
        VALUES
          (1, '[]')
        UNION ALL
        SELECT
          idx + 1,
          JSON_INSERT(
            verses,
            '$[#]',
            (
              (
                WITH
                  lines (line) AS (
                    SELECT
                      PRINTF(
                        'I know an old lady who swallowed a %s.',
                        (
                          SELECT
                            animal
                          FROM
                            chainmap
                          WHERE
                            id = idx
                        )
                      )
                    UNION ALL
                    SELECT
                      phrase
                    FROM
                      chainmap
                    WHERE
                      id = idx
                    UNION ALL
                    SELECT
                      IIF(
                        idx = 1,
                        NULL,
                        PRINTF(
                          'She swallowed the %s to catch the %s',
                          (
                            SELECT
                              animal
                            FROM
                              chainmap
                            WHERE
                              id = idx
                          ),
                          (
                            SELECT
                              animal
                            FROM
                              chainmap
                            WHERE
                              id = idx - 1
                          )
                        ) || IIF(
                          idx = 3,
                          REPLACE(
                            RTRIM(JSON_EXTRACT(verses, '$[1][1]'), '.'),
                            'It ',
                            ' that '
                          ),
                          ''
                        ) || '.'
                      )
                    UNION ALL
                    SELECT
                      IIF(
                        idx >= 4
                        AND j.key = 1,
                        NULL,
                        j.value
                      )
                    FROM
                      JSON_EACH(
                        JSON_EXTRACT(verses, PRINTF('$[%d]', IIF(idx = 1, 0, idx - 2)))
                      ) j
                    WHERE
                      j.key != 0
                      AND j.value NOT LIKE '%It wriggled and jiggled and tickled inside her.%'
                  )
                SELECT
                  JSON_GROUP_ARRAY(line)
                FROM
                  lines
                WHERE
                  line NOTNULL
              )
            )
          )
        FROM
          reciter
        WHERE
          idx <= (
            SELECT
              COUNT(*)
            FROM
              chainmap
          )
      )
    SELECT
      j.key + 1,
      j.value
    FROM
      JSON_EACH(
        (
          SELECT
            JSON_SET(
              verses,
              '$[#-1]',
              JSON_EXTRACT(verses, '$[#-1][0]', '$[#-1][1]')
            )
          FROM
            reciter
          ORDER BY
            idx DESC
          LIMIT
            1
        )
      ) j
  )
INSERT INTO
  lyrics (id, verse)
SELECT
  id,
  (
    SELECT
      GROUP_CONCAT(j.value, CHAR(10))
    FROM
      JSON_EACH(verse) j
  ) AS verse
FROM
  verses;

UPDATE "food-chain"
SET
  result = (
    SELECT
      GROUP_CONCAT(verse, CHAR(10) || CHAR(10))
    FROM
      lyrics
    WHERE
      id BETWEEN start_verse AND end_verse
  );

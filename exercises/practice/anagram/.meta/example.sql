DROP TABLE IF EXISTS tmp;

CREATE TEMPORARY TABLE tmp AS
SELECT
  CAST(word AS TEXT) word
FROM
  (
    SELECT
      LOWER(subject) word
    FROM
      anagram
    UNION
    SELECT
      LOWER(j.VALUE)
    FROM
      anagram,
      JSON_EACH(candidates) j
  );

ALTER TABLE tmp
ADD s TEXT;

UPDATE tmp
SET
  s = (
    WITH RECURSIVE
      rcte (word, c) AS (
        VALUES
          (word, '')
        UNION ALL
        SELECT
          SUBSTR(word, 2),
          SUBSTR(word, 1, 1)
        FROM
          rcte
        WHERE
          LENGTH(word) > 0
      )
    SELECT
      GROUP_CONCAT(c, '')
    FROM
      (
        SELECT
          c
        FROM
          rcte
        WHERE
          UNICODE(c) BETWEEN UNICODE('a') AND UNICODE('z')
        ORDER BY
          c
      )
  );

UPDATE anagram
SET
  result = (
    SELECT
      JSON_GROUP_ARRAY(candidate)
    FROM
      (
        SELECT
          subject,
          candidate,
          (
            SELECT
              s
            FROM
              tmp
            WHERE
              LOWER(subject) = word
          ) AS a,
          (
            SELECT
              s
            FROM
              tmp
            WHERE
              LOWER(candidate) = word
          ) AS b
        FROM
          (
            SELECT
              subject,
              j.VALUE AS candidate
            FROM
              JSON_EACH(candidates) AS j
          )
      )
    WHERE
      a = b
      AND LOWER(subject) <> LOWER(candidate)
  );

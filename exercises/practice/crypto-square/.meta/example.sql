DROP TABLE IF EXISTS tmp;

CREATE TEMPORARY TABLE tmp (plaintext TEXT PRIMARY KEY, normalized TEXT);

INSERT INTO
  tmp
SELECT
  plaintext,
  COALESCE(
    (
      WITH RECURSIVE
        rcte (string, chr) AS (
          VALUES
            (LOWER(plaintext), NULL)
          UNION ALL
          SELECT
            SUBSTR(string, 2),
            IIF(
              GLOB('[^0-9a-z]', SUBSTR(string, 1, 1)),
              NULL,
              SUBSTR(string, 1, 1)
            )
          FROM
            rcte
          WHERE
            string <> ''
        )
      SELECT
        GROUP_CONCAT(chr, '')
      FROM
        rcte
      WHERE
        chr NOTNULL
    ),
    ''
  )
FROM
  "crypto-square";

ALTER TABLE tmp
ADD COLUMN cols INTEGER;

UPDATE tmp
SET
  cols = ROUND(CEIL(sqrt(LENGTH(normalized))));

ALTER TABLE tmp
ADD COLUMN square TEXT;

WITH
  to_square (plaintext, string) AS (
    SELECT
      plaintext,
      (
        WITH RECURSIVE
          rcte (string, chr) AS (
            VALUES
              (tmp.normalized, NULL)
            UNION ALL
            SELECT
              SUBSTR(string, 2),
              SUBSTR(string, 1, 1)
            FROM
              rcte
            WHERE
              string <> ''
          )
        SELECT
          GROUP_CONCAT(chunk, CHAR(10))
        FROM
          (
            SELECT
              PRINTF('%-*s', tmp.cols, GROUP_CONCAT(chr, '')) chunk
            FROM
              (
                SELECT
                  (ROW_NUMBER() OVER () - 1) / tmp.cols AS gid,
                  chr
                FROM
                  rcte
                WHERE
                  chr NOTNULL
              )
            GROUP BY
              gid
          )
      )
    FROM
      tmp
  )
UPDATE tmp
SET
  square = string
FROM
  to_square
WHERE
  tmp.plaintext = to_square.plaintext;

ALTER TABLE tmp
ADD COLUMN matrix TEXT;

WITH
  to_matrix (plaintext, matrix) AS (
    SELECT
      plaintext,
      (
        WITH RECURSIVE
          split_lines (text, array) AS (
            VALUES
              (tmp.square || CHAR(10), NULL)
            UNION ALL
            SELECT
              SUBSTR(text, INSTR(text, CHAR(10)) + 1),
              (
                WITH RECURSIVE
                  split_chars (string, chr) AS (
                    VALUES
                      (
                        PRINTF(
                          '%-*s',
                          tmp.cols,
                          SUBSTR(text, 1, INSTR(text, CHAR(10)) - 1)
                        ),
                        NULL
                      )
                    UNION ALL
                    SELECT
                      SUBSTR(string, 2),
                      SUBSTR(string, 1, 1)
                    FROM
                      split_chars
                    WHERE
                      string <> ''
                  )
                SELECT
                  JSON_GROUP_ARRAY(chr)
                FROM
                  split_chars
                WHERE
                  chr NOTNULL
              )
            FROM
              split_lines
            WHERE
              text <> ''
          )
        SELECT
          JSON_GROUP_ARRAY(JSON(array))
        FROM
          split_lines
        WHERE
          array NOTNULL
      )
    FROM
      tmp
  )
UPDATE tmp
SET
  matrix = to_matrix.matrix
FROM
  to_matrix
WHERE
  tmp.plaintext = to_matrix.plaintext;

WITH
  to_encode (plaintext, encoded) AS (
    SELECT
      plaintext,
      COALESCE(
        (
          SELECT
            GROUP_CONCAT(line, ' ')
          FROM
            (
              SELECT
                GROUP_CONCAT(j.value, '') line
              FROM
                JSON_TREE(tmp.matrix) j
              WHERE
                j.type <> 'array'
              GROUP BY
                SUBSTR(j.fullkey, INSTR(j.fullkey, ']['))
            )
        ),
        ''
      )
    FROM
      tmp
  )
UPDATE "crypto-square" AS cs
SET
  result = encoded
FROM
  to_encode AS te
WHERE
  cs.plaintext = te.plaintext;

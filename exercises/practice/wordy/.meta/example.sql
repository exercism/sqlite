DROP TABLE IF EXISTS dict;

CREATE TEMPORARY TABLE dict (key TEXT NOT NULL, value TEXT NOT NULL);

INSERT INTO
  dict (key, value)
VALUES
  ('What is', '='),
  ('plus', '+'),
  ('minus', '-'),
  ('multiplied by', '*'),
  ('divided by', '/'),
  ('?', '?');

DROP TABLE IF EXISTS tmp;

CREATE TEMPORARY TABLE tmp (question TEXT NOT NULL, normalized TEXT);

INSERT INTO
  tmp
SELECT
  question,
  (
    WITH RECURSIVE
      normalizer (string, tokens, idx) AS (
        VALUES
          (
            REPLACE(wordy.question, '?', ' ?'),
            (
              SELECT
                JSON_GROUP_ARRAY(JSON(array))
              FROM
                (
                  SELECT
                    JSON_ARRAY(key, value) AS ARRAY
                  FROM
                    dict
                )
            ),
            0
          )
        UNION ALL
        SELECT
          REPLACE(
            string,
            JSON_EXTRACT(tokens, PRINTF('$[%d][0]', idx)),
            JSON_EXTRACT(tokens, PRINTF('$[%d][1]', idx))
          ),
          tokens,
          idx + 1
        FROM
          normalizer
        WHERE
          idx < JSON_ARRAY_LENGTH(tokens)
      )
    SELECT
      string
    FROM
      normalizer
    WHERE
      idx = (
        SELECT
          MAX(idx)
        FROM
          normalizer
      )
  )
FROM
  wordy;

ALTER TABLE tmp
ADD COLUMN tokens TEXT;

WITH
  to_tokens (question, tokens) AS (
    SELECT
      question,
      (
        WITH RECURSIVE
          tokenizer (string, token) AS (
            VALUES
              (tmp.normalized || ' ', NULL)
            UNION ALL
            SELECT
              SUBSTR(string, INSTR(string, ' ') + 1),
              SUBSTR(string, 1, INSTR(string, ' ') - 1)
            FROM
              tokenizer
            WHERE
              string <> ''
            LIMIT
              10
          )
        SELECT
          JSON_GROUP_ARRAY(token) tokens
        FROM
          tokenizer
        WHERE
          token NOTNULL
      )
    FROM
      tmp
  )
UPDATE tmp
SET
  tokens = to_tokens.tokens
FROM
  to_tokens
WHERE
  tmp.question = to_tokens.question;

UPDATE wordy
SET
  error = 'unknown operation'
FROM
  tmp
WHERE
  wordy.question = tmp.question
  AND (
    JSON_EXTRACT(tokens, '$[0]') <> '='
    OR JSON_EXTRACT(tokens, '$[#]') <> '?'
    OR (
      SELECT
        1
      FROM
        JSON_EACH(tokens) j
      WHERE
        j.value NOT IN (
          SELECT
            value
          FROM
            dict
        )
        AND NOT (REGEXP ('^-?[0-9]+$', j.VALUE))
    )
  )
  AND error ISNULL;

UPDATE wordy
SET
  error = 'syntax error'
FROM
  tmp
WHERE
  wordy.question = tmp.question
  AND REGEXP (
    '^= -?[0-9]+( [-+*/] -?[0-9]+)* \?$',
    tmp.normalized
  ) != 1
  AND wordy.error ISNULL;

UPDATE wordy
SET
  result = (
    WITH RECURSIVE
      calc (expr) AS (
        VALUES
          (JSON_REMOVE(tmp.tokens, '$[#-1]', '$[0]'))
        UNION ALL
        SELECT
          JSON_SET(
            JSON_REMOVE(expr, '$[0]', '$[0]'),
            '$[0]',
            CASE JSON_EXTRACT(expr, '$[1]')
              WHEN '+' THEN JSON_EXTRACT(expr, '$[0]') + JSON_EXTRACT(expr, '$[2]')
              WHEN '-' THEN JSON_EXTRACT(expr, '$[0]') - JSON_EXTRACT(expr, '$[2]')
              WHEN '*' THEN JSON_EXTRACT(expr, '$[0]') * JSON_EXTRACT(expr, '$[2]')
              WHEN '/' THEN JSON_EXTRACT(expr, '$[0]') / JSON_EXTRACT(expr, '$[2]')
            END
          )
        FROM
          calc
        WHERE
          JSON_ARRAY_LENGTH(expr) >= 3
      )
    SELECT
      JSON_EXTRACT(expr, '$[0]')
    FROM
      calc
    WHERE
      JSON_ARRAY_LENGTH(expr) = 1
  )
FROM
  tmp
WHERE
  wordy.question = tmp.question
  AND error ISNULL;

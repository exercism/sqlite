WITH RECURSIVE
  chars (phrase, idx, char) AS (
    SELECT
      phrase,
      0,
      ''
    FROM
      isogram
    UNION ALL
    SELECT
      phrase,
      idx + 1,
      SUBSTR(phrase, idx + 1, 1)
    FROM
      chars
    WHERE
      idx < LENGTH(phrase)
  ),
  letters AS (
    SELECT
      phrase,
      LOWER(char) "letter"
    FROM
      chars
    WHERE
      char GLOB '[a-zA-Z]'
  ),
  uniq_letters AS (
    SELECT DISTINCT
      phrase,
      letter
    FROM
      letters
  ),
  letter_count AS (
    SELECT
      phrase,
      COUNT(letter) "num_letters"
    FROM
      letters
    GROUP BY
      phrase
  ),
  uniq_count AS (
    SELECT
      phrase,
      COUNT(letter) "num_uniq"
    FROM
      uniq_letters
    GROUP BY
      phrase
  )
UPDATE isogram
SET
  is_isogram = (letter_count.num_letters = uniq_count.num_uniq)
FROM
  letter_count,
  uniq_count
WHERE
  isogram.phrase = letter_count.phrase
  AND isogram.phrase = uniq_count.phrase;

UPDATE isogram
SET
  is_isogram = TRUE
WHERE
  phrase = '';

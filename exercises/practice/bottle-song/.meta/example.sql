DROP TABLE IF EXISTS pairs;

CREATE TEMPORARY TABLE pairs (
  verse_number INTEGER NOT NULL,
  start_number TEXT NOT NULL,
  next_number TEXT NOT NULL
);

INSERT INTO
  pairs (verse_number, start_number, next_number)
VALUES
  (10, 'Ten', 'Nine'),
  (9, 'Nine', 'Eight'),
  (8, 'Eight', 'Seven'),
  (7, 'Seven', 'Six'),
  (6, 'Six', 'Five'),
  (5, 'Five', 'Four'),
  (4, 'Four', 'Three'),
  (3, 'Three', 'Two'),
  (2, 'Two', 'One'),
  (1, 'One', 'no');

DROP TABLE IF EXISTS verses;

CREATE TABLE verses AS
SELECT
  verse_number,
  PRINTF(
    '%s green bottles hanging on the wall,' || CHAR(10),
    start_number
  ) || PRINTF(
    '%s green bottles hanging on the wall,' || CHAR(10),
    start_number
  ) || 'And if one green bottle should accidentally fall,' || CHAR(10) || PRINTF(
    'There''ll be %s green bottles hanging on the wall.',
    LOWER(next_number)
  ) AS verse
FROM
  pairs;

UPDATE verses
SET
  verse = REPLACE(
    verse,
    'be one green bottles',
    'be one green bottle'
  )
WHERE
  verse_number = 2;

UPDATE verses
SET
  verse = REPLACE(verse, 'One green bottles', 'One green bottle')
WHERE
  verse_number = 1;

UPDATE "bottle-song"
SET
  result = (
    SELECT
      GROUP_CONCAT(verse, CHAR(10) || CHAR(10))
    FROM
      (
        SELECT
          verse
        FROM
          verses
        WHERE
          verse_number <= start_bottles
          AND verse_number > start_bottles - take_down
        ORDER BY
          verse_number DESC
      )
  );

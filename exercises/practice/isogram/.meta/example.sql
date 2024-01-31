UPDATE isogram
SET is_isogram = TRUE
WHERE phrase = '';

WITH RECURSIVE chars(phrase, str, idx, char) AS (
    SELECT phrase, REPLACE(REPLACE(LOWER(phrase), ' ', ''), '-', '') "str", 0, ''
    FROM isogram

    UNION ALL

    SELECT phrase, str, idx + 1, SUBSTR(str, idx + 1, 1)
    FROM chars
    WHERE idx < LENGTH(str)
)
, distinct_chars AS (
    SELECT DISTINCT phrase, str, char
    FROM chars
    WHERE char != ''
)
, counts AS (
    SELECT phrase, LENGTH(str) "str_len", COUNT(char) "num_chars"
    FROM distinct_chars
    GROUP BY phrase, str
)
UPDATE isogram
SET is_isogram = (counts.str_len = counts.num_chars)
FROM counts
WHERE isogram.phrase = counts.phrase;

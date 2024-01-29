WITH trimmed AS (
    SELECT input
         , RTRIM(input, CHAR(32, 9, 10, 13)) AS trimmed
    FROM bob
)
, bools AS (
    SELECT input
         , trimmed = '' AS is_silence
         , trimmed LIKE '%?' AS is_question
         , trimmed GLOB '*[a-zA-Z]*' AND trimmed = UPPER(trimmed) AS is_yelling
    FROM trimmed
)
UPDATE bob
SET reply =
    CASE
        WHEN bools.is_silence
            THEN 'Fine. Be that way!'
        WHEN bools.is_yelling AND bools.is_question
            THEN 'Calm down, I know what I''m doing!'
        WHEN bools.is_yelling
            THEN 'Whoa, chill out!'
        WHEN bools.is_question
            THEN 'Sure.'
        ELSE 'Whatever.'
    END
FROM bools
WHERE bob.input = bools.input;

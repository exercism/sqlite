UPDATE bowling
   SET error = 'Negative roll is invalid'
 WHERE (SELECT 1
          FROM JSON_EACH(
                 IIF(property = 'roll',
                     JSON_INSERT(previous_rolls, '$[#]', roll),
                     previous_rolls
                )
          )
         WHERE value < 0
       )
   AND error ISNULL
;

UPDATE bowling
   SET error = 'Pin count exceeds pins on the lane'
 WHERE (SELECT 1
          FROM JSON_EACH(
                 IIF(property = 'roll',
                     JSON_INSERT(previous_rolls, '$[#]', roll),
                     previous_rolls
                )
              )
         WHERE value > 10
       )
   AND error ISNULL
;

DROP TABLE IF EXISTS tmp;
CREATE TEMPORARY TABLE tmp (
  rolls  TEXT PRIMARY KEY,
  frames TEXT NOT NULL
);

WITH cte (prevrolls) AS (
  SELECT IIF(property = 'roll',
             JSON_INSERT(previous_rolls, '$[#]', roll),
             previous_rolls
         )
    FROM bowling
   WHERE error ISNULL
)
INSERT INTO tmp (rolls, frames)
SELECT prevrolls,
       (WITH RECURSIVE framer (rolls, frame, frame_id) AS (
         VALUES (prevrolls, '[]', 0)
         UNION ALL
         SELECT CASE
                WHEN JSON_EXTRACT(rolls, '$[0]') = 10
                THEN JSON_REMOVE(rolls, '$[0]')
                ELSE JSON_REMOVE(rolls, '$[0]', '$[0]')
                END,
                CASE
                WHEN JSON_EXTRACT(rolls, '$[0]') = 10 THEN
                  CASE
                  WHEN frame_id + 1 < 10
                  THEN JSON_EXTRACT(rolls, '$[0]', '$[1]', '$[2]')
                  ELSE JSON_EXTRACT(rolls, '$[0]')
                  END
                WHEN JSON_EXTRACT(rolls, '$[0]') +
                    JSON_EXTRACT(rolls, '$[1]') = 10 THEN
                  CASE
                  WHEN frame_id + 1 < 10
                  THEN JSON_EXTRACT(rolls, '$[0]', '$[1]', '$[2]')
                  ELSE JSON_EXTRACT(rolls, '$[0]', '$[1]')
                  END
               WHEN JSON_EXTRACT(rolls, '$[0]') +
                    JSON_EXTRACT(rolls, '$[1]') > 10
               THEN JSON_OBJECT('error', 'Pin count exceeds pins on the lane')
               ELSE JSON_EXTRACT(rolls, '$[0]', '$[1]')
               END,
               frame_id + 1
               END
          FROM framer
         WHERE JSON_TYPE(frame) != 'object'
           AND JSON_ARRAY_LENGTH(rolls) > 0
       )
       SELECT JSON_GROUP_ARRAY(JSON(frame)) frames
         FROM framer
        WHERE frame_id > 0
       ) AS frames
  FROM cte
;

WITH cte (rolls, error) AS (
  SELECT rolls, JSON_EXTRACT(j.value, '$.error')
    FROM tmp, JSON_EACH(frames) j
   WHERE type = 'object'
)
UPDATE bowling
   SET error = cte.error
  FROM cte
 WHERE IIF(property = 'roll',
           JSON_INSERT(previous_rolls, '$[#]', roll),
           previous_rolls
       ) = cte.rolls
   AND bowling.error ISNULL
;

UPDATE bowling
   SET error = 'Score cannot be taken until the end of the game'
  FROM tmp
 WHERE IIF(property = 'roll',
           JSON_INSERT(previous_rolls, '$[#]', roll),
           previous_rolls
       ) = tmp.rolls
   AND property = 'score'
   AND bowling.error ISNULL
   AND (JSON_ARRAY_LENGTH(frames) < 10
        OR (
          JSON_EXTRACT(frames, '$[9]') = 10
          AND JSON_ARRAY_LENGTH(frames) < 11
          OR (JSON_EXTRACT(frames, '$[9]', '$[10]') = JSON_ARRAY(10, 10)
              AND JSON_ARRAY_LENGTH(frames) < 12)
              OR (JSON_EXTRACT(frames, '$[9][0]') +
                  JSON_EXTRACT(frames, '$[9][1]') = 10
                  AND JSON_ARRAY_LENGTH(frames) < 11)))
;

UPDATE bowling
   SET error = 'Cannot roll after game is over'
  FROM tmp
 WHERE IIF(property = 'roll',
             JSON_INSERT(previous_rolls, '$[#]', roll),
             previous_rolls
       ) = tmp.rolls
   AND property = 'roll'
   AND bowling.error ISNULL
   AND JSON_ARRAY_LENGTH(frames) > 10
   AND (
     (JSON_EXTRACT(frames, '$[9]') != 10
     AND (SELECT SUM(VALUE)
            FROM JSON_EACH(JSON_EXTRACT(frames, '$[9]'))) != 10
     )
     OR (
       JSON_EXTRACT(frames, '$[9]') != 10
       AND (SELECT SUM(VALUE)
              FROM JSON_EACH(JSON_EXTRACT(frames, '$[9]'))) = 10
              AND JSON_EXTRACT(frames, '$[10][1]') NOTNULL
     )
     OR (
       JSON_EXTRACT(frames, '$[9]') = 10
       AND (SELECT SUM(VALUE)
              FROM JSON_EACH(JSON_EXTRACT(frames, '$[10]'))
       ) < 10
       AND JSON_EXTRACT(frames, '$[11]') NOTNULL
     )
   )
;

WITH cte (rolls, score) AS (
  SELECT rolls,
         (SELECT SUM((SELECT SUM(jb.value) FROM JSON_EACH(ja.value) jb))
            FROM JSON_EACH(frames) ja)
    FROM tmp
)
UPDATE bowling
   SET result = score
  FROM cte
 WHERE IIF(property = 'roll',
           JSON_INSERT(previous_rolls, '$[#]', roll),
           previous_rolls
       ) = cte.rolls
  AND bowling.error ISNULL
;

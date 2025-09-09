UPDATE "robot-simulator"
SET
  result = input
WHERE
  property = 'create';

DROP TABLE IF EXISTS directions;

CREATE TABLE directions (
  direction TEXT NOT NULL,
  angle INTEGER NOT NULL,
  axis TEXT NOT NULL,
  incr INTEGER NOT NULL
);

INSERT INTO
  directions (direction, angle, axis, incr)
VALUES
  ('north', 0, 'y', 1),
  ('east', 90, 'x', 1),
  ('south', 180, 'y', -1),
  ('west', 270, 'x', -1);

DROP TABLE IF EXISTS tmp;

CREATE TEMPORARY TABLE tmp (input TEXT PRIMARY KEY, output TEXT NOT NULL);

INSERT INTO
  tmp
SELECT
  input,
  JSON_SET(
    input,
    '$.instructions',
    (
      WITH RECURSIVE
        rcte (string, chr) AS (
          VALUES
            (JSON_EXTRACT(input, '$.instructions'), NULL)
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
        JSON_GROUP_ARRAY(chr)
      FROM
        rcte
      WHERE
        chr NOTNULL
    )
  )
FROM
  "robot-simulator"
WHERE
  property = 'move';

UPDATE "robot-simulator"
SET
  result = (
    WITH RECURSIVE
      rcte (jobject, instructions, lr, dirmap) AS (
        VALUES
          (
            JSON_REMOVE(tmp.output, '$.instructions'),
            JSON_EXTRACT(tmp.output, '$.instructions'),
            '{"L": -90, "R": 90}',
            (
              SELECT
                JSON_GROUP_OBJECT(
                  direction,
                  JSON_OBJECT('axis', axis, 'incr', incr)
                )
              FROM
                directions
            )
          )
        UNION ALL
        SELECT
          CASE
            WHEN JSON_EXTRACT(instructions, '$[0]') IN ('R', 'L') THEN JSON_SET(
              jobject,
              '$.direction',
              (
                SELECT
                  direction
                FROM
                  directions
                WHERE
                  angle = (
                    SELECT
                      (
                        360 + angle + JSON_EXTRACT(
                          lr,
                          PRINTF('$.%s', JSON_EXTRACT(instructions, '$[0]'))
                        )
                      ) % 360
                    FROM
                      directions
                    WHERE
                      direction = JSON_EXTRACT(jobject, '$.direction')
                  )
              )
            )
            WHEN JSON_EXTRACT(instructions, '$[0]') = 'A' THEN JSON_SET(
              jobject,
              PRINTF(
                '$.position.%s',
                JSON_EXTRACT(
                  dirmap,
                  PRINTF('$.%s.axis', JSON_EXTRACT(jobject, '$.direction'))
                )
              ),
              JSON_EXTRACT(
                jobject,
                PRINTF(
                  '$.position.%s',
                  JSON_EXTRACT(
                    dirmap,
                    PRINTF('$.%s.axis', JSON_EXTRACT(jobject, '$.direction'))
                  )
                )
              ) + JSON_EXTRACT(
                dirmap,
                PRINTF('$.%s.incr', JSON_EXTRACT(jobject, '$.direction'))
              )
            )
            ELSE jobject
          END,
          JSON_REMOVE(instructions, '$[0]'),
          lr,
          dirmap
        FROM
          rcte
        WHERE
          JSON_ARRAY_LENGTH(instructions) > 0
      )
    SELECT
      jobject
    FROM
      rcte
    WHERE
      JSON_ARRAY_LENGTH(instructions) = 0
  )
FROM
  tmp
WHERE
  "robot-simulator".input = tmp.input;

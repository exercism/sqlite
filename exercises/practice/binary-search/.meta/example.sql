UPDATE "binary-search"
   SET error = 'value not in array'
 WHERE JSON(array) = '[]'
;

DROP TABLE IF EXISTS tmp;
CREATE TEMPORARY TABLE tmp (
  array  TEXT    NOT NULL,
  value  INTEGER NOT NULL,
  result TEXT,
  PRIMARY KEY(array, value)
);

INSERT INTO tmp
SELECT
  array,
  value,
  (WITH RECURSIVE rcte (list, target) AS (
    VALUES ((
      SELECT JSON_GROUP_ARRAY(JSON_ARRAY(j.value, j.key))
        FROM JSON_EACH("binary-search".array) j),
        "binary-search".value
    )
    UNION
    SELECT CASE
           WHEN JSON_EXTRACT(
                  list, PRINTF('$[%d][0]', JSON_ARRAY_LENGTH(list) / 2)
                ) = target
                THEN JSON_ARRAY(
                       JSON_EXTRACT(
                         list,PRINTF('$[%d]', JSON_ARRAY_LENGTH(list) / 2)))
           WHEN JSON_EXTRACT(
                  list, PRINTF('$[%d][0]', JSON_ARRAY_LENGTH(list) / 2)
                ) > target
                THEN (SELECT JSON_GROUP_ARRAY(j.value)
                        FROM JSON_EACH(list) j
                       WHERE j.key < JSON_ARRAY_LENGTH(list) / 2)
           WHEN JSON_EXTRACT(
                  list, PRINTF('$[%d][0]', JSON_ARRAY_LENGTH(list) / 2)
                ) < target
                THEN (SELECT JSON_GROUP_ARRAY(j.value)
                        FROM JSON_EACH(list) j
                       WHERE j.key > JSON_ARRAY_LENGTH(list) / 2)
           END,
           target
      FROM rcte
     WHERE JSON_ARRAY_LENGTH(list) > 1
  )
  SELECT IIF(JSON_EXTRACT(list, '$[0][0]') != target,
             JSON_OBJECT('error', 'value not in array'),
             JSON_OBJECT('result', JSON_EXTRACT(list, '$[0][1]'))
         )
    FROM rcte
   WHERE JSON_ARRAY_LENGTH(list) = 1
  )
  FROM "binary-search"
 WHERE JSON(array) != '[]'
;

UPDATE "binary-search"
   SET error = JSON_EXTRACT(tmp.result, '$."error"')
  FROM tmp
 WHERE "binary-search".array = tmp.array
   AND "binary-search".value = tmp.value
   AND JSON_EXTRACT(tmp.result, '$."error"') NOTNULL
;

UPDATE "binary-search"
   SET result = JSON_EXTRACT(tmp.result, '$."result"')
  FROM tmp
 WHERE "binary-search".array = tmp.array
   AND "binary-search".value = tmp.value
   AND JSON_EXTRACT(tmp.result, '$."result"') NOTNULL
;

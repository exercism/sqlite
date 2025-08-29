UPDATE sublist
SET
  result = 'equal'
WHERE
  JSON(list_one) = JSON(list_two);

UPDATE sublist
SET
  result = (
    WITH RECURSIVE
      to_subl (list, i, len, subl) AS (
        VALUES
          (
            list_two,
            0,
            JSON_ARRAY_LENGTH(list_one) - 1,
            NULL
          )
        UNION ALL
        SELECT
          list,
          i + 1,
          len,
          (
            SELECT
              JSON_GROUP_ARRAY(value)
            FROM
              (
                SELECT
                  j.value
                FROM
                  json_each(list) j
                WHERE
                  KEY BETWEEN i AND len  + i
              )
          )
        FROM
          to_subl
        WHERE
          i + len < JSON_ARRAY_LENGTH(list)
      )
    SELECT
      'sublist'
    FROM
      to_subl
    WHERE
      JSON(list_one) = JSON(subl)
    LIMIT
      1
  )
WHERE
  NULLIF(result, '') ISNULL
  AND JSON_ARRAY_LENGTH(list_one) < JSON_ARRAY_LENGTH(list_two);

UPDATE sublist
SET
  result = (
    WITH RECURSIVE
      to_subl (list, i, len, subl) AS (
        VALUES
          (
            list_one,
            0,
            JSON_ARRAY_LENGTH(list_two) - 1,
            NULL
          )
        UNION ALL
        SELECT
          list,
          i + 1,
          len,
          (
            SELECT
              JSON_GROUP_ARRAY(value)
            FROM
              (
                SELECT
                  j.value
                FROM
                  json_each(list) j
                WHERE
                  KEY BETWEEN i AND len  + i
              )
          )
        FROM
          to_subl
        WHERE
          i + len < JSON_ARRAY_LENGTH(list)
      )
    SELECT
      'superlist'
    FROM
      to_subl
    WHERE
      JSON(list_two) = JSON(subl)
    LIMIT
      1
  )
WHERE
  NULLIF(result, '') ISNULL
  AND JSON_ARRAY_LENGTH(list_one) > JSON_ARRAY_LENGTH(list_two);

UPDATE SUBLIST
SET
  result = 'unequal'
WHERE
  NULLIF(result, '') ISNULL;

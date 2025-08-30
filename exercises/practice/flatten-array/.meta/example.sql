UPDATE "flatten-array"
SET
  result = (
    SELECT
      JSON_GROUP_ARRAY(j.value)
    FROM
      JSON_TREE(JSON(array)) j
    WHERE
      j.type <> 'array'
      AND j.value NOTNULL
  );

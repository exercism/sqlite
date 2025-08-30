UPDATE "reverse-string"
SET
  result = (
    WITH RECURSIVE
      reverse_char (string, char) AS (
        VALUES
          (input, '')
        UNION ALL
        SELECT
          SUBSTRING(string, 1, LENGTH(string) - 1),
          SUBSTRING(string, -1)
        FROM
          reverse_char
        WHERE
          string <> ''
      )
    SELECT
      GROUP_CONCAT(char, '')
    FROM
      reverse_char
  );

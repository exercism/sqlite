UPDATE "rotational-cipher"
SET
  result = (
    WITH RECURSIVE
      rcte (text, chr, shift) AS (
        VALUES
          (text, NULL, NULL)
        UNION ALL
        SELECT
          SUBSTR(text, 2),
          SUBSTR(text, 1, 1),
          IIF(
            GLOB('[A-Za-z]', SUBSTR(text, 1, 1)),
            UNICODE(SUBSTR(text, 1, 1)) + shift_key,
            UNICODE(SUBSTR(text, 1, 1))
          )
        FROM
          rcte
        WHERE
          text <> ''
      )
    SELECT
      GROUP_CONCAT(
        CHAR(
          CASE
            WHEN GLOB('[A-Z]', chr)
            AND shift > UNICODE('Z') THEN shift - UNICODE('Z') + UNICODE('A') - 1
            WHEN GLOB('[a-z]', chr)
            AND shift > UNICODE('z') THEN shift - UNICODE('z') + UNICODE('a') - 1
            ELSE shift
          END
        ),
        ''
      )
    FROM
      rcte
    WHERE
      chr NOTNULL
  );

UPDATE diamond
SET
  result = (
    WITH
      lengths (len, chr) AS (
        SELECT
          (ROW_NUMBER() OVER () - 1) * 2,
          CHAR(value)
        FROM
          GENERATE_SERIES (UNICODE('A'), UNICODE(letter))
      ),
      lines (line) AS (
        SELECT
          IIF(chr = 'A', chr, PRINTF('%-*c%c', len, chr, chr))
        FROM
          lengths
      ),
      padding (rn, line) AS (
        SELECT
          ROW_NUMBER() OVER (),
          PRINTF('%*s%s%-*s', pad, '', line, pad, '')
        FROM
          (
            SELECT
              line,
              (
                SELECT
                  MAX(LENGTH(line))
                FROM
                  lines
              ) len,
              (
                (
                  SELECT
                    MAX(LENGTH(line))
                  FROM
                    lines
                ) - LENGTH(line)
              ) / 2 pad
            FROM
              lines
          )
      ),
      top (line) AS (
        SELECT
          line
        FROM
          padding
        ORDER BY
          rn ASC
      ),
      bottom (line) AS (
        SELECT
          line
        FROM
          padding
        WHERE
          rn < (
            SELECT
              MAX(rn)
            FROM
              padding
          )
        ORDER BY
          rn DESC
      )
    SELECT
      GROUP_CONCAT(line, CHAR(10))
    FROM
      (
        SELECT
          line
        FROM
          top
        UNION ALL
        SELECT
          line
        FROM
          bottom
      )
  );

DROP TABLE IF EXISTS jmatrix;
CREATE TEMPORARY TABLE jmatrix AS
SELECT lines,
  (
    WITH to_line (line) AS (
      WITH RECURSIVE split_lines (string, line) AS (
        VALUES (REPLACE(lines, ' ', CHAR(7))||CHAR(10), NULL)
        UNION ALL
        SELECT SUBSTR(string, INSTR(string, CHAR(10)) + 1),
               SUBSTR(string, 1, INSTR(string, CHAR(10)) - 1)
          FROM split_lines
         WHERE string <> ''
      )
      SELECT line FROM split_lines WHERE line NOTNULL
    )
    SELECT JSON_GROUP_ARRAY(
      (
        WITH RECURSIVE to_letter (string, letter) AS (
          VALUES (
            PRINTF('%-*s', (SELECT MAX(LENGTH(line)) FROM to_line), line),
            NULL
          )
          UNION ALL
          SELECT SUBSTR(string, 2), SUBSTR(string, 1, 1)
            FROM to_letter
           WHERE string <> ''
        )
        SELECT JSON_GROUP_ARRAY(letter)
          FROM to_letter
         WHERE letter NOTNULL
      )
    ) AS matrix
      FROM to_line
  ) AS matrix
  FROM transpose
;

UPDATE transpose SET result = '' WHERE lines = '';

UPDATE transpose
   SET result = (
     WITH RECURSIVE to_transpose (jarray, idx, ncols, new_row) AS (
       VALUES (
         jmatrix.matrix,
         0,
         JSON_ARRAY_LENGTH(JSON_EXTRACT(jmatrix.matrix, '$[0]')),
         NULL
       )
       UNION ALL
       SELECT jarray, idx + 1, ncols, (
         SELECT GROUP_CONCAT(JSON_EXTRACT(j.value, PRINTF('$[%d]', idx)), '')
           FROM JSON_EACH(jarray) j
       )
         FROM to_transpose
        WHERE idx < ncols
     )
     SELECT GROUP_CONCAT(REPLACE(RTRIM(new_row,' '), CHAR(7), ' '), CHAR(10))
       FROM to_transpose
   )
  FROM jmatrix
 WHERE transpose.lines = jmatrix.lines
   AND result ISNULL
;

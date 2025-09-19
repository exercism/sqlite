DROP TABLE IF EXISTS tmp;
CREATE TEMPORARY TABLE tmp (
  msg    TEXT    NOT NULL,
  rails  INTEGER NOT NULL,
  fence  TEXT    NOT NULL,
  to_enc TEXT            ,
  to_dec TEXT
);
WITH cte AS (
  SELECT msg,
         rails,
         (WITH RECURSIVE
            gen_matrix (rowid, colid, maxrow, maxcol, fill, matrix) AS (
           VALUES (0, 0, rails - 1, LENGTH(msg) - 1, NULL, '[[]]')
           UNION ALL
           SELECT IIF(colid = maxcol, rowid + 1, rowid),
                  IIF(colid = maxcol, 0, colid + 1),
                  maxrow,
                  maxcol,
                  fill,
                  JSON_INSERT(matrix, PRINTF('$[%d][%d]', rowid, colid), fill)
             FROM gen_matrix
            WHERE rowid <= maxrow
         )
         SELECT matrix
           FROM gen_matrix
          ORDER BY rowid DESC, colid DESC
          LIMIT 1
         ) AS fence
    FROM "rail-fence-cipher"
)
INSERT INTO tmp (msg, rails, fence)
SELECT msg, rails, fence
  FROM cte
;

WITH cte AS (
SELECT msg,
       rails,
       (WITH cte AS (
         WITH RECURSIVE
           rcte (strlen, nrails, flow, row, col, matrix, to_enc) AS (
             VALUES (LENGTH(msg), rails,'D', 0, 0, fence, '[]')
             UNION ALL
             SELECT strlen,
                    nrails,
                    -- CASE row
                    -- WHEN 2 THEN 'U'
                    -- WHEN 0 THEN 'D'
                    -- ELSE flow
                    -- END,
                    -- IIF(row > 0 AND (row % (nrails - 1) = 0 OR flow = 'U'),
                    --     row - 1,
                    --     row + 1
                    -- ),
    CASE
    WHEN row = nrails - 2 THEN 'U'
    WHEN row = 0      THEN 'D'
    ELSE flow
    END,
    IIF(flow = 'U' AND row > 0,
        row - 1,
        row + 1
    ),
                    col + 1,
                    JSON_SET(matrix, PRINTF('$[%d][%d]', row, col), '?'),
                    JSON_INSERT(to_enc, '$[#]', PRINTF('$[%d][%d]', row, col))
               FROM rcte
              WHERE col < strlen
           )
         SELECT matrix, to_enc
           FROM rcte
          ORDER BY col DESC
          LIMIT 1
       )
       SELECT
         JSON_OBJECT(
           'matrix', JSON(matrix),
           'to_enc', JSON(to_enc),
           'to_dec', (
             WITH jrows (jkey, jrow) AS (
               SELECT key, VALUE FROM cte, JSON_EACH(matrix)
             )
             SELECT JSON_GROUP_ARRAY(PRINTF('$[%d][%d]', jkey, j.key)) to_dec
               FROM jrows, JSON_EACH(jrow) j
              WHERE j.value = '?'
             )
         ) jobj
         FROM cte
       ) AS jobj
  FROM tmp
)
UPDATE tmp
   SET fence  = JSON_EXTRACT(jobj, '$.matrix'),
       to_enc = JSON_EXTRACT(jobj, '$.to_enc'),
       to_dec = JSON_EXTRACT(jobj, '$.to_dec')
  FROM cte
 WHERE tmp.msg  = cte.msg
   AND tmp.rails = cte.rails
;

WITH cipher AS (
SELECT tmp.msg,
       tmp.rails,
       (WITH
          cte AS (
            WITH RECURSIVE rcte (string, paths, matrix) AS (
              VALUES (msg, IIF(property = 'encode', to_enc, to_dec), fence)
              UNION ALL
              SELECT SUBSTR(string, 2),
              JSON_REMOVE(paths, '$[0]'),
              JSON_SET(
                matrix,
                JSON_EXTRACT(paths, '$[0]'),
                SUBSTR(string, 1, 1)
              )
              FROM rcte
              WHERE string <> ''
            )
            SELECT matrix
              FROM rcte
             ORDER BY LENGTH(string)
             LIMIT 1
          ),
          join_row_encode (string) AS (
            SELECT (SELECT GROUP_CONCAT(jb.VALUE, '')
                      FROM JSON_EACH(ja.VALUE) jb
            )
              FROM cte, JSON_EACH(matrix) ja
          ),
          join_row_decode (string) AS (
            SELECT JSON_EXTRACT(matrix, j.value) AS chr
              FROM cte, JSON_EACH(to_enc) j
            )
       SELECT
         IIF(
           property = 'encode',
           (SELECT GROUP_CONCAT(string, '') FROM join_row_encode),
           (SELECT GROUP_CONCAT(string, '') FROM join_row_decode)
         )
       ) AS result
  FROM "rail-fence-cipher" JOIN tmp USING (msg, rails)
)
UPDATE "rail-fence-cipher"
   SET result = cipher.result
  FROM cipher
 WHERE "rail-fence-cipher".msg      = cipher.msg
   AND "rail-fence-cipher".rails    = cipher.rails
;

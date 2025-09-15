DROP TABLE IF EXISTS letters;
CREATE TEMPORARY TABLE letters (
  grid TEXT    NOT NULL,
  chr  TEXT    NOT NULL,
  row  INTEGER NOT NULL,
  col  INTEGER NOT NULL
);
WITH
  to_lines AS (
    SELECT grid,
           j.value AS line,
           LENGTH(j.value) AS len,
           j.key AS row
      FROM (SELECT DISTINCT JSON_EXTRACT(input, '$.grid') AS grid
              FROM "word-SEARCH"),
           JSON_EACH(grid) j
  ),
  to_chars AS (
    SELECT grid, SUBSTR(line, g.value, 1) AS chr, row, g.value - 1 col
      FROM to_lines, GENERATE_SERIES(1, to_lines.len) g
  )
INSERT INTO letters
      (grid, chr, row, col)
SELECT grid, chr, row, col
  FROM to_chars
;

DROP TABLE IF EXISTS strings;
CREATE TEMPORARY TABLE strings (
  grid   TEXT NOT NULL,
  string TEXT NOT NULL,
  array  TEXT NOT NULL
);
-- INSERT INTO strings (grid, string, array)
-- SELECT grid,
--        GROUP_CONCAT(chr, ''),
--        JSON_GROUP_ARRAY(JSON_ARRAY(chr, JSON_ARRAY(row, col)))
--   FROM (
--     SELECT grid, chr, row, col
--       FROM letters
--      ORDER BY row ASC, col ASC
--   )
--  GROUP BY grid, row
-- HAVING LENGTH(GROUP_CONCAT(chr, '')) > 1
-- ;
-- INSERT INTO strings (grid, string, array)
-- SELECT grid,
--        GROUP_CONCAT(chr, ''),
--        JSON_GROUP_ARRAY(JSON_ARRAY(chr, JSON_ARRAY(row, col)))
--   FROM (
--     SELECT grid, chr, row, col
--       FROM letters
--      ORDER BY row DESC, col DESC
--   )
--  GROUP BY grid, row
-- HAVING LENGTH(GROUP_CONCAT(chr, '')) > 1
-- ;
-- INSERT INTO strings (grid, string, array)
-- SELECT grid,
--        GROUP_CONCAT(chr, ''),
--        JSON_GROUP_ARRAY(JSON_ARRAY(chr, JSON_ARRAY(row, col)))
--   FROM (
--     SELECT grid, chr, row, col
--       FROM letters
--      ORDER BY col ASC, row ASC
--   )
--  GROUP BY grid, col
-- HAVING LENGTH(GROUP_CONCAT(chr, '')) > 1
-- ;
-- INSERT INTO strings (grid, string, array)
-- SELECT grid,
--        GROUP_CONCAT(chr, ''),
--        JSON_GROUP_ARRAY(JSON_ARRAY(chr, JSON_ARRAY(row, col)))
--   FROM (
--     SELECT grid, chr, row, col
--       FROM letters
--      ORDER BY col DESC, row DESC
--   )
--  GROUP BY grid, col
-- HAVING LENGTH(GROUP_CONCAT(chr, '')) > 1
-- ;

WITH
  bounds (grid, mrow, mcol) AS (
    SELECT grid, MAX(row), MAX(col)
      FROM letters
     GROUP BY grid
  ),
  starts AS (
    SELECT grid,
           gr.value row,
           gc.value col
      FROM bounds, GENERATE_SERIES(0, mrow) gr, GENERATE_SERIES(0, mcol) gc
  ),
  r2l_coords AS (
    SELECT grid,
           JSON_GROUP_ARRAY(JSON(coord)) AS coords
      FROM (
        SELECT DISTINCT
          starts.grid,
          row,
          col,
          JSON_ARRAY(row + g.value, col + g.value) coord
          FROM bounds, starts, GENERATE_SERIES(0, mrow) g
         WHERE bounds.grid = starts.grid
           AND row + g.value <= mrow
           AND col + g.value <= mcol
      )
     GROUP BY grid, row, col
    HAVING JSON_ARRAY_LENGTH(coords) > 1
  ),
  l2r_coords AS (
    SELECT grid,
           JSON_GROUP_ARRAY(JSON(coord)) AS coords
      FROM (
        SELECT DISTINCT
          starts.grid,
          row,
          col,
          g.VALUE,
          JSON_ARRAY(row + g.value, col - g.value) coord
          FROM bounds, starts, GENERATE_SERIES(0, mrow) g
         WHERE bounds.grid = starts.grid
           AND row + g.VALUE <= mrow
           AND col - g.VALUE >= 0
      )
     GROUP BY grid, row, col
    HAVING JSON_ARRAY_LENGTH(coords) > 1
  ),
  chrs AS (
    SELECT letters.*,
           JSON_ARRAY(letters.row, letters.col) AS row_col,
           r2l_coords.coords
      FROM letters, r2l_coords
     WHERE letters.grid = r2l_coords.grid
       AND row_col IN ((SELECT j.value FROM JSON_EACH(coords) j))
     UNION ALL
    SELECT letters.*,
           JSON_ARRAY(letters.row, letters.col) AS row_col,
           l2r_coords.coords
      FROM letters, l2r_coords
     WHERE letters.grid = l2r_coords.grid
       AND row_col IN ((SELECT j.value FROM JSON_EACH(coords) j))
  )
    INSERT INTO strings (grid, string, array)
SELECT *
  FROM (
    SELECT grid,
           GROUP_CONCAT(chr, '') AS string,
           JSON_GROUP_ARRAY(JSON_ARRAY(chr, JSON_ARRAY(row, col))) array
      FROM (SELECT * FROM chrs ORDER BY grid, row_col ASC)
     GROUP BY grid, coords
  )
 UNION ALL
SELECT *
  FROM (
    SELECT grid,
           GROUP_CONCAT(chr, '') AS string,
           JSON_GROUP_ARRAY(JSON_ARRAY(chr, JSON_ARRAY(row, col))) array
      FROM (SELECT * FROM chrs ORDER BY grid, row_col DESC)
     GROUP BY grid, coords
  )
;

WITH
  find AS (
    SELECT input,
           j.value AS word,
           (SELECT
              JSON_EXTRACT(
                array,
                PRINTF('$[%d][1]', INSTR(string, j.value) - 1),
                PRINTF('$[%d][1]', INSTR(string, j.VALUE) +
                       LENGTH(j.value) - 2
                )
              )
              FROM strings
             WHERE JSON_EXTRACT(input, '$.grid') = grid
               AND INSTR(string, j.value)
           ) AS bounds
      FROM "word-search",
           JSON_EACH(JSON_EXTRACT(input, '$.wordsToSearchFor')) j
  ),
  results AS (
    SELECT input,
           JSON_GROUP_OBJECT(word, JSON(object)) result
      FROM (
        SELECT
          input,
          word,
          IIF(
            bounds ISNULL,
            bounds,
            JSON_OBJECT(
              'start',
              JSON_OBJECT(
                'column', JSON_EXTRACT(bounds, '$[0][1]') + 1,
                'row',    JSON_EXTRACT(bounds, '$[0][0]') + 1
              ),
              'end',
              JSON_OBJECT(
                'column', JSON_EXTRACT(bounds, '$[1][1]') + 1,
                'row',    JSON_EXTRACT(bounds, '$[1][0]') + 1
              )
            )
          ) object
          FROM find
         ORDER BY input, word
      )
     GROUP BY input
  )
UPDATE "word-search"
   SET result = results.result
  FROM results
 WHERE "word-search".input = results.input
;

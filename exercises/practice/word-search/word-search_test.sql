-- Create database:
.read ./create_fixture.sql

-- Read user student solution and save any output as markdown in user_output.md:
.mode markdown
.output user_output.md
.read ./word-search.sql
.output

-- Create a clean testing environment:
.read ./create_test_table.sql

-- Comparison of user input and the tests updates the status for each test:
UPDATE tests
   SET status = 'pass'
  FROM (SELECT input, result FROM "word-search") AS actual
 WHERE actual.input = tests.input
  AND (SELECT
         NOT EXISTS (
           SELECT j.key, j.value FROM JSON_EACH(actual.result) j
           EXCEPT
           SELECT j.key, j.value FROM JSON_EACH(tests.expected) j
         ) AND NOT EXISTS (
           SELECT j.key, j.value FROM JSON_EACH(tests.expected) j
           EXCEPT
           SELECT j.key, j.value FROM JSON_EACH(actual.result) j
         )
      )
  ;

-- Update message for failed tests to give helpful information:
UPDATE tests
   SET message = (
        'Result for "' || tests.input || '"' || ' is <' ||
         COALESCE(actual.result, 'NULL') || '> but should be <' ||
         tests.expected || '>'
       )
  FROM (SELECT input, result FROM "word-search") AS actual
 WHERE actual.input = tests.input
   AND tests.status = 'fail'
;

-- Hacking errors ---------------------------------------------
INSERT INTO tests (uuid, description, input, expected, message)
VALUES
('a', '', '', '', (
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
          g.value,
          JSON_ARRAY(row + g.value, col - g.value) coord
          FROM bounds, starts, GENERATE_SERIES(0, mrow) g
         WHERE bounds.grid = starts.grid
           AND row + g.value <= mrow
           AND col - g.value >= 0
      )
     GROUP BY grid, row, col
    HAVING JSON_ARRAY_LENGTH(coords) > 1
  ),
    chrs AS (
      SELECT * FROM (
    SELECT letters.*,
           JSON_ARRAY(letters.row, letters.col) AS row_col,
           r2l_coords.coords
      FROM letters, r2l_coords
     WHERE letters.grid = r2l_coords.grid
       AND row_col IN ((SELECT j.value FROM JSON_EACH(coords) j))
)
       UNION ALL
      SELECT * FROM (
    SELECT letters.*,
           JSON_ARRAY(letters.row, letters.col) AS row_col,
           l2r_coords.coords
      FROM letters, l2r_coords
     WHERE letters.grid = l2r_coords.grid
       AND row_col IN ((SELECT j.value FROM JSON_EACH(coords) j))
      )
             ),
  straight AS (
    SELECT grid,
           GROUP_CONCAT(chr, '') AS string,
           JSON_GROUP_ARRAY(JSON_ARRAY(chr, JSON_ARRAY(row, col))) array
      FROM (SELECT * FROM chrs ORDER BY grid, row_col ASC)
     GROUP BY grid, coords
  ),
  reversed AS (
    SELECT grid,
           GROUP_CONCAT(chr, '') AS string,
           JSON_GROUP_ARRAY(JSON_ARRAY(chr, JSON_ARRAY(row, col))) array
      FROM (SELECT * FROM chrs ORDER BY grid, row_col DESC)
     GROUP BY grid, coords
  )
  SELECT COUNT(*) FROM chrs
) )
       ;
---------------------------------------------------------------

-- Save results to ./output.json (needed by the online test-runner)
.mode json
.once './output.json'
SELECT
  description,
  status,
  message,
  output,
  test_code,
  task_id
FROM
  tests;

-- Display test results in readable form for the student:
.mode table
SELECT
  description,
  status,
  message
FROM
  tests;

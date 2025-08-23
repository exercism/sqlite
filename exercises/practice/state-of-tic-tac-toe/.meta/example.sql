DROP TABLE IF EXISTS matrices;
CREATE TEMPORARY TABLE matrices AS
  SELECT board, (
    WITH RECURSIVE split_lines (string, line) AS (
      VALUES (board||CHAR(10), NULL)
      UNION ALL
      SELECT SUBSTR(string,    INSTR(string, CHAR(10)) + 1),
             SUBSTR(string, 1, INSTR(string, CHAR(10)) - 1)
        FROM split_lines
       WHERE string <> ''
    )
    SELECT JSON_GROUP_ARRAY((
      WITH RECURSIVE split_letters (string, letter) AS (
        VALUES (line, NULL)
        UNION ALL
        SELECT SUBSTR(string, 2), SUBSTR(string, 1, 1)
          FROM split_letters
         WHERE string <> ''
      )
      SELECT JSON_GROUP_ARRAY(letter) letters
        FROM split_letters
       WHERE letter NOTNULL
    )) matrix
      FROM split_lines
     WHERE line NOTNULL
  ) matrix
  FROM "state-of-tic-tac-toe";

ALTER TABLE matrices ADD has_win TEXT;

UPDATE matrices
   SET has_win = (
     SELECT JSON_GROUP_ARRAY(JSON(won))
       FROM (
         SELECT j.value AS won FROM JSON_EACH(matrix) j
          UNION
         SELECT JSON_GROUP_ARRAY(JSON_EXTRACT(j.value, '$[0]'))
           FROM JSON_EACH(matrix) j
          UNION
         SELECT JSON_GROUP_ARRAY(JSON_EXTRACT(j.value, '$[1]'))
           FROM JSON_EACH(matrix) j
          UNION
         SELECT JSON_GROUP_ARRAY(JSON_EXTRACT(j.value, '$[2]'))
           FROM JSON_EACH(matrix) j
          UNION
         SELECT
           JSON_ARRAY(
             JSON_EXTRACT(matrix, '$[0][0]'),
             JSON_EXTRACT(matrix, '$[1][1]'),
             JSON_EXTRACT(matrix, '$[2][2]')
           )
          UNION
         SELECT
           JSON_ARRAY(
             JSON_EXTRACT(matrix, '$[0][2]'),
             JSON_EXTRACT(matrix, '$[1][1]'),
             JSON_EXTRACT(matrix, '$[2][0]')
           )
       )
      WHERE won IN ('["X","X","X"]', '["O","O","O"]')
   );

UPDATE "state-of-tic-tac-toe" AS t
   SET error = 'Wrong turn order: X went twice'
 FROM matrices AS m
 WHERE t.board = m.board
   AND (
     WITH cte AS (SELECT j.value AS jrow FROM JSON_EACH(m.matrix) j)
     SELECT COUNT(*) FILTER (WHERE j.value = 'X') =
            COUNT(*) FILTER (WHERE j.value = 'O') + 2
       FROM cte, JSON_EACH(jrow) j
   )
;

UPDATE "state-of-tic-tac-toe" AS t
   SET error = 'Wrong turn order: O started'
 FROM matrices AS m
 WHERE t.board = m.board
   AND (
     WITH cte AS (SELECT j.value AS jrow FROM JSON_EACH(m.matrix) j)
     SELECT COUNT(*) FILTER (WHERE j.value = 'O') =
            COUNT(*) FILTER (WHERE j.value = 'X') + 1
       FROM cte, JSON_EACH(jrow) j
   )
;

UPDATE "state-of-tic-tac-toe" AS t
   SET error = 'Impossible board: game should have ended after the game was won'
       FROM matrices AS m
 WHERE t.board = m.board
   AND JSON_ARRAY_LENGTH(m.has_win) = 2
   AND (
     WITH cte AS (SELECT j.value AS jrow FROM JSON_EACH(m.matrix) j)
     SELECT COUNT(*) <= 3 FROM cte, JSON_EACH(jrow) j WHERE j.value = ' '
   )
;

UPDATE "state-of-tic-tac-toe" AS t
   SET result = 'win'
  FROM matrices AS m
 WHERE t.board = m.board
   AND t.error ISNULL
   AND JSON_ARRAY_LENGTH(m.has_win) = 1
;

UPDATE "state-of-tic-tac-toe" AS t
   SET result = 'draw'
  FROM matrices AS m
 WHERE t.board = m.board
   AND t.error ISNULL
   AND JSON_ARRAY_LENGTH(m.has_win) = 0
   AND (
     WITH cte AS (SELECT j.value AS jrow FROM JSON_EACH(m.matrix) j)
     SELECT COUNT(*) = 0 FROM cte, JSON_EACH(jrow) j WHERE j.value = ' '
   )
;

UPDATE "state-of-tic-tac-toe" AS t
   SET result = 'ongoing'
  FROM matrices AS m
 WHERE t.board = m.board
   AND t.error ISNULL
   AND JSON_ARRAY_LENGTH(m.has_win) = 0
   AND (
     WITH cte AS (SELECT j.value AS jrow FROM JSON_EACH(m.matrix) j)
     SELECT COUNT(*) > 0 FROM cte, JSON_EACH(jrow) j WHERE j.value = ' '
   )
;

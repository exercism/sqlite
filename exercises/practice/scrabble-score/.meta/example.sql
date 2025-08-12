DROP TABLE IF EXISTS score;
CREATE TABLE score AS
  SELECT *
    FROM (
      WITH score_data (letter, value) AS (
        VALUES ('["A","E","I","O","U","L","N","R","S","T"]',  1),
               ('["D","G"]'                                ,  2),
               ('["B","C","M","P"]'                        ,  3),
               ('["F","H","V","W","Y"]'                    ,  4),
               ('["K"]'                                    ,  5),
               ('["J","X"]'                                ,  8),
               ('["Q","Z"]'                                , 10)
      ) SELECT * FROM score_data
);

UPDATE "scrabble-score"
   SET result = (
     WITH RECURSIVE letter_points (string, points) AS (
       VALUES(UPPER(word), 0)
       UNION ALL
       SELECT SUBSTRING(string, 2), (
              SELECT s.value
                FROM score s, JSON_EACH(s.letter) j
               WHERE j.value = SUBSTRING(string, 1, 1)
              )
         FROM letter_points
        WHERE string <> ''
     ) SELECT SUM(points) FROM letter_points
   );

DROP TABLE IF EXISTS dict;
CREATE TABLE dict (
  code  INTEGER,
  color TEXT
);
INSERT INTO dict (code, color)
VALUES
(0, 'black'  ),
(1, 'brown'  ),
(2, 'red'    ),
(3, 'orange' ),
(4, 'yellow' ),
(5, 'green'  ),
(6, 'blue'   ),
(7, 'violet' ),
(8, 'grey'   ),
(9, 'white'  );

UPDATE color_code
   SET result = (
     WITH value AS (
       SELECT (
         (SELECT code FROM dict WHERE color = color1) * 10
         + (SELECT code FROM dict WHERE color = color2))
         * POW(10, (SELECT code FROM dict WHERE color = color3))
       AS v
     )
     SELECT
       CASE
       WHEN v >= 1e9 THEN CAST(v / 1e9 AS INTEGER) || ' gigaohms'
       WHEN v >= 1e6 THEN CAST(v / 1e6 AS INTEGER) || ' megaohms'
       WHEN v >= 1e3 THEN CAST(v / 1e3 AS INTEGER) || ' kiloohms'
       ELSE CAST(v AS INTEGER) || ' ohms'
       END
       FROM value
   )
;

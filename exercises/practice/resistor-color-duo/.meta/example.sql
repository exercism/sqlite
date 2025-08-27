-- CREATE TABLE "color_code" ("color1" TEXT, "color2" TEXT, "result" INT);
DROP TABLE IF EXISTS "colors";

CREATE TABLE "colors" ("index" INT, "color" TEXT);

INSERT INTO
  "colors" ("index", "color")
VALUES
  (0, 'black'),
  (1, 'brown'),
  (2, 'red'),
  (3, 'orange'),
  (4, 'yellow'),
  (5, 'green'),
  (6, 'blue'),
  (7, 'violet'),
  (8, 'grey'),
  (9, 'white');

UPDATE color_code
SET
  result = (
    SELECT
      (c1."index" * 10) + c2."index"
    FROM
      colors AS c1,
      colors AS c2
    WHERE
      c1.color = color_code.color1
      AND c2.color = color_code.color2
  );

DROP TABLE IF EXISTS "colors";

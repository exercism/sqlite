-- CREATE TABLE "color_code" ("color" TEXT, "result" INT);

DROP TABLE IF EXISTS "colors";
CREATE TABLE "colors" ("index" INT, "color" TEXT);

INSERT INTO "colors" ("index", "color")
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
        (9, 'white')
;

UPDATE color_code
    SET result = (
        SELECT "index" FROM "colors"
        WHERE colors.color = color_code.color
    )
;

DROP TABLE IF EXISTS "colors";

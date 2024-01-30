-- CREATE TABLE "colors" ("index" INT, "color" TEXT);
-- CREATE TABLE "color_code" ("color" TEXT, "result" INT);
INSERT INTO "colors" ("index", "color")
    VALUES
        (6, 'blue'),
        (3, 'orange'),
        (7, 'violet'),
        (2, 'red'),
        (1, 'brown'),
        (0, 'black'),
        (9, 'white'),
        (5, 'green'),
        (4, 'yellow'),
        (8, 'grey')
;

UPDATE color_code
    SET result = (
        SELECT "index" FROM "colors"
        WHERE colors.color = color_code.color
    )
;

-- The colors table holds all the colors in the correct order.
DROP TABLE IF EXISTS "colors";
CREATE TABLE "colors" (
    "index" INT, "color" TEXT
);

-- The color_code has specific colors and needs the result filled in.
DROP TABLE IF EXISTS "color_code";
CREATE TABLE "color_code" (
    "color" TEXT, "result" INT
);
.mode csv
.import ./data.csv color_code

DROP TABLE IF EXISTS "roman-numerals";
CREATE TABLE "roman-numerals" (
    "number" INT,
    "result" TEXT
);

.mode csv
.import ./data.csv roman-numerals

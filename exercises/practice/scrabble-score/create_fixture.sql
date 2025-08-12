DROP TABLE IF EXISTS "scrabble-score";
CREATE TABLE "scrabble-score" (
    word   TEXT    NOT NULL,
    result INTEGER
);

.mode csv
.import ./data.csv "scrabble-score"

UPDATE "scrabble-score" SET result = NULL;

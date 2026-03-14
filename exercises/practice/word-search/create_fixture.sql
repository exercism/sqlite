DROP TABLE IF EXISTS "word-search";
CREATE TABLE "word-search" (
  input  TEXT NOT NULL,   -- json object
  result TEXT             -- json object
);

.mode csv
.import ./data.csv "word-search"

UPDATE "word-search" SET result = NULL;

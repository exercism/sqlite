DROP TABLE IF EXISTS "binary-search";
CREATE TABLE "binary-search" (
  array  TEXT    NOT NULL,    -- json array
  value  INTEGER NOT NULL,
  result INTEGER         ,
  error  TEXT
);

.mode csv
.import ./data.csv "binary-search"

UPDATE "binary-search" SET result = NULL, error = NULL;


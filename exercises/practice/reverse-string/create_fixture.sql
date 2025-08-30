DROP TABLE IF EXISTS "reverse-string";

CREATE TABLE "reverse-string" (input TEXT NOT NULL, result TEXT);

.mode csv
.import ./data.csv reverse-string
UPDATE "reverse-string"
SET
  result = NULL;

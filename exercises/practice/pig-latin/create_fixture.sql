DROP TABLE IF EXISTS "pig-latin";

CREATE TABLE "pig-latin" (phrase TEXT NOT NULL, result TEXT);

.mode csv
.import ./data.csv "pig-latin"
UPDATE "pig-latin"
SET
  result = NULL;

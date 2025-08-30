DROP TABLE IF EXISTS "protein-translation";

CREATE TABLE "protein-translation" (strand TEXT NOT NULL, result TEXT, error TEXT);

.mode csv
.import ./data.csv "protein-translation"
UPDATE "protein-translation"
SET
  result = NULL,
  error = NULL;

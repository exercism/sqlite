DROP TABLE IF EXISTS "perfect-numbers";

CREATE TABLE "perfect-numbers" (number INTEGER NOT NULL, result TEXT, error TEXT);

.mode csv
.import ./data.csv "perfect-numbers"
UPDATE "perfect-numbers"
SET
  result = NULL,
  error = NULL;

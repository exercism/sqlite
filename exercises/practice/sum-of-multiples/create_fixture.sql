DROP TABLE IF EXISTS "sum-of-multiples";

CREATE TABLE "sum-of-multiples" (
  factors TEXT NOT NULL, -- json array of integers
  "limit" INTEGER NOT NULL,
  result INTEGER
);

.mode csv
.import ./data.csv "sum-of-multiples"
UPDATE "sum-of-multiples"
SET
  result = NULL;

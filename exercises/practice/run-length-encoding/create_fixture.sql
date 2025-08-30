DROP TABLE IF EXISTS "run-length-encoding";

CREATE TABLE "run-length-encoding" (
  property TEXT NOT NULL,
  string TEXT NOT NULL,
  result TEXT
);

.mode csv
.import ./data.csv "run-length-encoding"
UPDATE "run-length-encoding"
SET
  result = NULL;

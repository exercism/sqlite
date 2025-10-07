DROP TABLE IF EXISTS "line-up";

CREATE TABLE "line-up" (
  name TEXT NOT NULL,
  number INTEGER NOT NULL,
  result TEXT
);

.mode csv
.import ./data.csv "line-up"

UPDATE "line-up"
SET
  result = NULL;

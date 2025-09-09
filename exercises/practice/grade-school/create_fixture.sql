DROP TABLE IF EXISTS "grade-school";
CREATE TABLE "grade-school" (
  property TEXT NOT NULL,
  input    TEXT NOT NULL,    -- json object
  result   TEXT              -- json array
);

.mode csv
.import ./data.csv "grade-school"

UPDATE "grade-school" SET result = NULL;

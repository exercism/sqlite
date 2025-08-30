DROP TABLE IF EXISTS "flatten-array";
CREATE TABLE "flatten-array" (
  array  TEXT NOT NULL,    -- json array
  result TEXT              -- json array
);

.mode csv
.import ./data.csv "flatten-array"
  
UPDATE "flatten-array" SET result = NULL;


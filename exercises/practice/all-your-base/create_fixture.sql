DROP TABLE IF EXISTS "all-your-base";

CREATE TABLE "all-your-base" (
  input_base INTEGER NOT NULL,
  digits TEXT NOT NULL, -- json array
  output_base INTEGER NOT NULL,
  result TEXT -- json object
);

.mode csv
.import ./data.csv "all-your-base"
UPDATE "all-your-base"
SET
  result = NULL;

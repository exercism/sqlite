DROP TABLE IF EXISTS "all-your-base";
CREATE TABLE "all-your-base" (
  input_base  INTEGER NOT NULL,
  digits      TEXT    NOT NULL,
  output_base INTEGER NOT NULL,
  result      TEXT
);

.mode csv
.import ./data.csv "all-your-base"

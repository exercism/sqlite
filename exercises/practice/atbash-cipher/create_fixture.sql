DROP TABLE IF EXISTS "atbash-cipher";

CREATE TABLE "atbash-cipher" (
  property TEXT NOT NULL,
  phrase TEXT NOT NULL,
  result TEXT
);

.mode csv
.import ./data.csv "atbash-cipher"

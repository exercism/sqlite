DROP TABLE IF EXISTS "rotational-cipher";

CREATE TABLE "rotational-cipher" (
  text TEXT NOT NULL,
  shift_key INTEGER NOT NULL,
  result TEXT
);

.mode csv
.import ./data.csv "rotational-cipher"
UPDATE "rotational-cipher"
SET
  result = NULL;

DROP TABLE IF EXISTS "crypto-square";
CREATE TABLE "crypto-square" (
  plaintext TEXT NOT NULL,
  result    TEXT
);

.mode csv
.import ./data.csv "crypto-square"

UPDATE "crypto-square" SET result = NULL;

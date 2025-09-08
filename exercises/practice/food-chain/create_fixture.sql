DROP TABLE IF EXISTS "food-chain";
CREATE TABLE "food-chain" (
  start_verse INTEGER NOT NULL,
  end_verse   INTEGER NOT NULL,
  result      TEXT
);

.mode csv
.import ./data.csv "food-chain"

UPDATE "food-chain" SET result = NULL;

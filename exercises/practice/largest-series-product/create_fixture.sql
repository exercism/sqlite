DROP TABLE IF EXISTS "largest-series-product";
CREATE TABLE "largest-series-product" (
  digits TEXT    NOT NULL,
  span   INTEGER NOT NULL,
  result INTEGER         ,
  error  TEXT
);

.mode csv
.import ./data.csv "largest-series-product"

UPDATE "largest-series-product" SET result = NULL, error = NULL;

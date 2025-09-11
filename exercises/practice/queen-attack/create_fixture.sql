DROP TABLE IF EXISTS "queen-attack";
CREATE TABLE "queen-attack" (
  property TEXT    NOT NULL,
  input    TEXT    NOT NULL,    -- json object
  result   BOOLEAN         ,
  error    TEXT
);

.mode csv
.import ./data.csv "queen-attack"

UPDATE "queen-attack" SET result = NULL, error = NULL;

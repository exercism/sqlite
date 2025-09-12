DROP TABLE IF EXISTS "queen-attack";
CREATE TABLE "queen-attack" (
  white_row INTEGER NOT NULL,
  white_col INTEGER NOT NULL,
  black_row INTEGER NOT NULL,
  black_col INTEGER NOT NULL,
  result    BOOLEAN         ,
  error     TEXT
);

.mode csv
.import ./data.csv "queen-attack"

UPDATE "queen-attack" SET result = NULL, error = NULL;

DROP TABLE IF EXISTS diamond;

CREATE TABLE diamond (letter TEXT NOT NULL, result TEXT);

.mode csv
.import ./data.csv diamond
UPDATE diamond
SET
  result = NULL;

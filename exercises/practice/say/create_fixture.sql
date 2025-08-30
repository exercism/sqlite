DROP TABLE IF EXISTS say;

CREATE TABLE say (number INTEGER NOT NULL, result TEXT, error TEXT);

.mode csv
.import ./data.csv say
UPDATE say
SET
  result = NULL,
  error = NULL;

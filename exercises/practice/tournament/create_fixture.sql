DROP TABLE IF EXISTS tournament;

CREATE TABLE tournament (input TEXT NOT NULL, result TEXT);

.mode csv
.import ./data.csv tournament
UPDATE tournament
SET
  input = REPLACE(input, '\n', CHAR(10));

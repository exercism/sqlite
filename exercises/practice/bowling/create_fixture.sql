DROP TABLE IF EXISTS bowling;
CREATE TABLE bowling (
  previous_rolls TEXT NOT NULL, -- json aray
  roll           INTEGER      ,
  result         INTEGER      ,
  error          TEXT
);

.mode csv
.import ./data.csv bowling

UPDATE bowling SET result = NULL, error = NULL;
UPDATE bowling SET roll = NULL WHERE roll = '';

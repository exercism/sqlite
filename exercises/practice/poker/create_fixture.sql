DROP TABLE IF EXISTS poker;
CREATE TABLE poker (
  hands  TEXT NOT NULL,   -- json array
  result TEXT             -- json array
);

.mode csv
.import ./data.csv poker

UPDATE poker SET result = NULL;

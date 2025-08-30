DROP TABLE IF EXISTS series;

CREATE TABLE series (
  input TEXT NOT NULL,
  slice_length INTEGER NOT NULL,
  result TEXT,
  error TEXT
);

.mode csv
.import ./data.csv series
UPDATE series
SET
  result = NULL,
  error = NULL;

DROP TABLE IF EXISTS acronym;
CREATE TABLE acronym (
  phrase TEXT PRIMARY KEY,
  result TEXT
);

-- Note: the CSV file may contain literal tab, newline, carriage returns.

.mode csv
.import ./data.csv acronym

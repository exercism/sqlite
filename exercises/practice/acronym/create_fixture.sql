DROP TABLE IF EXISTS acronym;
CREATE TABLE acronym (
  phrase TEXT PRIMARY KEY,
  result TEXT
);

.mode csv
.import ./data.csv acronym

DROP TABLE IF EXISTS sieve;
CREATE TABLE sieve (
  "limit" INTEGER NOT NULL,
  result  TEXT
);

.mode csv
.import ./data.csv sieve

UPDATE sieve SET result = NULL;

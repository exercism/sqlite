DROP TABLE IF EXISTS hamming;
CREATE TABLE hamming (
    strand1 TEXT NOT NULL,
    strand2 TEXT NOT NULL,
    result  INTEGER,
    error   TEXT
);

.mode csv
.import ./data.csv hamming

UPDATE hamming SET result = NULL, error = NULL;

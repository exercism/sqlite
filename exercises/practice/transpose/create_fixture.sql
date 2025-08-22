DROP TABLE IF EXISTS transpose;
CREATE TABLE transpose (
    lines  TEXT NOT NULL,
    result TEXT
);

.mode csv
.import ./data.csv transpose

UPDATE transpose SET result = NULL;
UPDATE transpose SET lines = REPLACE(lines, '\n', CHAR(10));

DROP TABLE IF EXISTS matrix;
CREATE TABLE matrix (
    property TEXT    NOT NULL,
    string   TEXT    NOT NULL,
    "index"  INTEGER NOT NULL,
    result   TEXT               -- json array of integers
);

.mode csv
.import ./data.csv matrix

UPDATE matrix SET result = NULL;
UPDATE matrix SET string = REPLACE(string, '\n', CHAR(10));

DROP TABLE IF EXISTS house;
CREATE TABLE house (
    start_verse INTEGER NOT NULL,
    end_verse   INTEGER NOT NULL,
    result      TEXT
);

.mode csv
.import ./data.csv house

UPDATE house SET result = NULL;

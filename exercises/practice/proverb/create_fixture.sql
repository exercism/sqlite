DROP TABLE IF EXISTS proverb;
CREATE TABLE proverb (
    strings TEXT NOT NULL,    -- json array
    result  TEXT
);

.mode csv
.import ./data.csv proverb

UPDATE proverb SET result = NULL;

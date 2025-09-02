DROP TABLE IF EXISTS wordy;
CREATE TABLE wordy (
  question TEXT    NOT NULL,
  result   INTEGER         ,
  error    TEXT
);

.mode csv
.import ./data.csv wordy

UPDATE wordy SET result = NULL, error = NULL;

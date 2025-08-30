DROP TABLE IF EXISTS 'rest-api';

CREATE TABLE 'rest-api' (
  'database' TEXT,
  'payload' TEXT,
  'url' TEXT,
  'result' TEXT
);

.mode csv
.import ./data.csv 'rest-api'

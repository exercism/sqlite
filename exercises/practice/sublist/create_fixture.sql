DROP TABLE IF EXISTS sublist;

CREATE TABLE sublist (
  list_one TEXT NOT NULL, -- json array
  list_two TEXT NOT NULL, -- json array
  result TEXT
);

.mode csv
.import ./data.csv sublist

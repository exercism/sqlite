DROP TABLE IF EXISTS anagram;

CREATE TABLE anagram (
  subject TEXT NOT NULL,
  candidates TEXT NOT NULL, -- json array of strings
  result TEXT -- json array of strings
);

.mode csv
.import ./data.csv anagram
UPDATE anagram
SET
  result = NULL;

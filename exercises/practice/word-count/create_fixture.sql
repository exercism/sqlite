DROP TABLE IF EXISTS "word-count";

CREATE TABLE "word-count" (
  sentence TEXT NOT NULL,
  result TEXT -- json object
);

.mode csv
.import ./data.csv "word-count"
UPDATE "word-count"
SET
  sentence = REPLACE(sentence, '\n', CHAR(10));

UPDATE "word-count"
SET
  result = NULL;

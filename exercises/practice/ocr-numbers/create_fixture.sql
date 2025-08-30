DROP TABLE IF EXISTS "ocr-numbers";
CREATE TABLE "ocr-numbers" (
    input   TEXT NOT NULL,
    result  TEXT         ,
    error   TEXT
);

.mode csv
.import ./data.csv "ocr-numbers"

UPDATE "ocr-numbers" SET result = NULL, error = NULL;
UPDATE "ocr-numbers" SET input = REPLACE(input, '\n', CHAR(10));

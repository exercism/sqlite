DROP TABLE IF EXISTS "isogram";
CREATE TABLE "isogram" (
    "phrase" TEXT,
    "is_isogram" INT
);

.mode csv
.import ./data.csv isogram

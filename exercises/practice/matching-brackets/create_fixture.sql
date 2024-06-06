DROP TABLE IF EXISTS "matching-brackets";
CREATE TABLE "matching-brackets" (
    "input" TEXT,
    "result" BOOLEAN
);

.mode csv
.import ./data.csv matching-brackets

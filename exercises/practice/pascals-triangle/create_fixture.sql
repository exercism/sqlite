DROP TABLE IF EXISTS "pascals-triangle";

CREATE TABLE "pascals-triangle" ("input" INT, "result" TEXT);

.mode csv
.import ./data.csv pascals-triangle

DROP TABLE IF EXISTS "armstrong-numbers";

CREATE TABLE "armstrong-numbers" ("number" INT, "result" BOOLEAN);

.mode csv
.import ./data.csv armstrong-numbers

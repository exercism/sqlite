DROP TABLE IF EXISTS "kindergarten-garden";

CREATE TABLE "kindergarten-garden" ("diagram" TEXT, "student" TEXT, "result" TEXT);

.mode csv
.import ./data.csv kindergarten-garden

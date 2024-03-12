DROP TABLE IF EXISTS "leap";
CREATE TABLE "leap" (
    "year" INT,
    "result" INT
);

.mode csv
.import ./data.csv leap
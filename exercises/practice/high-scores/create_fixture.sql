DROP TABLE IF EXISTS "scores";
CREATE TABLE "scores" (
    "uuid" TEXT,
    "score" INT
);

DROP TABLE IF EXISTS "results";
CREATE TABLE "results" (
    "uuid" TEXT,
    "property" TEXT,
    "result" TEXT
);

.mode csv
.import ./data_scores.csv scores
.import ./data_results.csv results

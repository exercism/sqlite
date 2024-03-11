DROP TABLE IF EXISTS "difference-of-squares";
CREATE TABLE "difference-of-squares" (
    "number" INT,
    "property" TEXT,
    "result" INT
);

-- Note: the CSV file may contain literal tab, newline, carriage returns.

.mode csv
.import ./data.csv difference-of-squares

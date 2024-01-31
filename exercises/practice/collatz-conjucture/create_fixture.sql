DROP TABLE IF EXISTS collatz;
CREATE TABLE "collatz" (
    "number" INTEGER,
    "steps" INTEGER
);

-- Note: the CSV file contain literal tab, newline, carriage returns.

.mode csv
.import ./data.csv collatz

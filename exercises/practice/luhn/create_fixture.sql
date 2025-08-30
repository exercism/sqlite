DROP TABLE IF EXISTS luhn;

CREATE TABLE "luhn" (value TEXT NOT NULL, result Boolean NOT NULL);

-- Note: the CSV file may contain literal tab, newline, carriage returns.
.mode csv
.import ./data.csv luhn

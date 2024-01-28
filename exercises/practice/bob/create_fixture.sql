DROP TABLE IF EXISTS heyBob;
CREATE TABLE "heyBob" (
    "input" TEXT,
    "reply" TEXT
);

-- Note: the CSV file contain literal tab, newline, carriage returns.

.mode csv
.import ./data.csv heyBob

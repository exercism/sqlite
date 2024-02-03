DROP TABLE IF EXISTS meetup;
CREATE TABLE "meetup" (
    "year" INTEGER,
    "month" INTEGER,
    "week" TEXT,
    "dayofweek" TEXT,
    "result" TEXT
);

-- Note: the CSV file contain literal tab, newline, carriage returns.

.mode csv
.import ./data.csv meetup

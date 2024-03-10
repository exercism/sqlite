DROP TABLE IF EXISTS "eliuds-eggs";
CREATE TABLE "eliuds-eggs" (
    "number" INT,
    "result" INT
);

-- Note: the CSV file contain literal tab, newline, carriage returns.

.mode csv
.import ./data.csv eliuds-eggs

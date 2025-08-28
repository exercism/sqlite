DROP TABLE IF EXISTS "armstrong-numbers";

CREATE TABLE "armstrong-numbers" ("number" INT, "result" BOOLEAN);

-- Note: the CSV file may contain literal tab, newline, carriage returns.
.mode csv
.import ./data.csv armstrong-numbers

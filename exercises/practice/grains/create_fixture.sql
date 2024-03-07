DROP TABLE IF EXISTS grains;
CREATE TABLE "grains" (
    "task" TEXT NOT NULL,
    "square" INT NOT NULL,
    "result" INT NOT NULL
);

-- Note: the CSV file may contain literal tab, newline, carriage returns.

.mode csv
.import ./data.csv grains

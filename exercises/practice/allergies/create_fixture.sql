DROP TABLE IF EXISTS allergies;

CREATE TABLE "allergies" (
  "task" TEXT,
  "item" TEXT,
  "score" INT NOT NULL,
  "result" TEXT
);

-- Note: the CSV file may contain literal tab, newline, carriage returns.
.mode csv
.import ./data.csv allergies

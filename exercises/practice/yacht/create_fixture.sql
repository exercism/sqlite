DROP TABLE IF EXISTS yacht;

CREATE TABLE "yacht" (
  "dice_results" TEXT NOT NULL,
  "category" TEXT NOT NULL,
  "result" INT NOT NULL
);

-- Note: the CSV file may contain literal tab, newline, carriage returns.
.mode csv
.import ./data.csv yacht

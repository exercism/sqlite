DROP TABLE IF EXISTS "twelve-days";
CREATE TABLE "twelve-days" (
    start_verse INTEGER NOT NULL,
    end_verse   INTEGER NOT NULL,
    result      TEXT
);

.mode csv
.import ./data.csv "twelve-days"

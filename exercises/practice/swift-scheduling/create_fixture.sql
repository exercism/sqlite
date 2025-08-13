DROP TABLE IF EXISTS "swift-scheduling";
CREATE TABLE "swift-scheduling" (
    meeting_start    TEXT NOT NULL, -- datetime YYYY-MM-DDTHH:mm:ss
    date_description TEXT NOT NULL,
    result           TEXT           -- datetime YYYY-MM-DDTHH:mm:ss
);

.mode csv
.import ./data.csv "swift-scheduling"

DROP TABLE IF EXISTS "robot-simulator";

CREATE TABLE "robot-simulator" (
  property TEXT NOT NULL,
  input TEXT NOT NULL, -- json object
  result TEXT -- json object
);

.mode csv
.import ./data.csv "robot-simulator"
UPDATE "robot-simulator"
SET
  result = NULL;

DROP TABLE IF EXISTS "saddle-points";
CREATE TABLE "saddle-points" (
    matrix TEXT NOT NULL,    -- json array of arrays
    result TEXT              -- json array of objects
);

.mode csv
.import ./data.csv "saddle-points"

UPDATE "saddle-points" SET result = NULL;

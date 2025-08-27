DROP TABLE IF EXISTS "square-root";
CREATE TABLE "square-root" (
    radicand INTEGER NOT NULL,
    result   INTEGER
);

.mode csv
.import ./data.csv "square-root"

UPDATE "square-root" SET result = NULL;

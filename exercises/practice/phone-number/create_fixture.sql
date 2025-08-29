DROP TABLE IF EXISTS "phone-number";
CREATE TABLE "phone-number" (
    phrase TEXT NOT NULL,
    result TEXT,
    error TEXT
);

.mode csv
.import ./data.csv "phone-number"

UPDATE "phone-number" SET result = NULL, error = NULL;

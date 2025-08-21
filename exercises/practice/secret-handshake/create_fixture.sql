DROP TABLE IF EXISTS "secret-handshake";
CREATE TABLE "secret-handshake" (
    number INTEGER NOT NULL,
    result TEXT
);

.mode csv
.import ./data.csv "secret-handshake"

UPDATE "secret-handshake" SET result = NULL;

DROP TABLE IF EXISTS "rail-fence-cipher";
CREATE TABLE "rail-fence-cipher" (
  property TEXT    NOT NULL,
  msg      TEXT    NOT NULL,
  rails    INTEGER NOT NULL,
  result   text
);

.mode csv
.import ./data.csv "rail-fence-cipher"

UPDATE "rail-fence-cipher" SET result = NULL;

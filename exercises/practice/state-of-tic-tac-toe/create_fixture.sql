DROP TABLE IF EXISTS "state-of-tic-tac-toe";

CREATE TABLE "state-of-tic-tac-toe" (board TEXT NOT NULL, result TEXT, error TEXT);

.mode csv
.import ./data.csv "state-of-tic-tac-toe"
UPDATE "state-of-tic-tac-toe"
SET
  board = REPLACE(board, '\n', CHAR(10)),
  result = NULL,
  error = NULL;

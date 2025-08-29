ALTER TABLE collatz
ADD current INTEGER;

UPDATE collatz
SET
  steps = 0;

PRAGMA recursive_triggers = ON;

CREATE TRIGGER IF NOT EXISTS update_collatz AFTER
UPDATE ON collatz WHEN NEW.current != 1 BEGIN
UPDATE collatz
SET
  current = IIF(
    NEW.current % 2 == 0,
    NEW.current / 2,
    NEW.current * 3 + 1
  ),
  steps = NEW.steps + 1
WHERE
  current = NEW.current;

END;

UPDATE collatz
SET
  current = number;

ALTER TABLE "armstrong-numbers"
ADD rest INTEGER;

ALTER TABLE "armstrong-numbers"
ADD exp INTEGER;

UPDATE "armstrong-numbers"
SET
  exp = IIF(
    INSTR(number, 'e') != 0,
    SUBSTR(number, INSTR(number, 'e') + 1, LENGTH(number)),
    LENGTH(NUMBER)
  );

UPDATE "armstrong-numbers"
SET
  result = 0;

PRAGMA recursive_triggers = ON;

CREATE TRIGGER IF NOT EXISTS "update_armstrong-numbers" AFTER
UPDATE ON "armstrong-numbers" WHEN NEW.rest > 0 BEGIN
UPDATE "armstrong-numbers"
SET
  rest = NEW.rest / 10,
  result = result + POWER(NEW.rest % 10, exp)
WHERE
  rest = NEW.rest;

END;

UPDATE "armstrong-numbers"
SET
  rest = IIF(
    INSTR(number, 'e') != 0,
    SUBSTR(
      REPLACE(number, '.', ''),
      0,
      INSTR(number, 'e') - 1
    ),
    number
  );

UPDATE "armstrong-numbers"
SET
  result = IIF(result = number, TRUE, FALSE);

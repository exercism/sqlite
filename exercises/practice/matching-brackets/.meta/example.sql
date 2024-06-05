ALTER TABLE "matching-brackets"
ADD brackets TEXT DEFAULT '';

PRAGMA recursive_triggers = ON;

CREATE TRIGGER IF NOT EXISTS update_backets
    AFTER UPDATE
    ON "matching-brackets"
    WHEN NEW.brackets != OLD.brackets
BEGIN
    UPDATE "matching-brackets"
    SET brackets = REPLACE(REPLACE(REPLACE(brackets, '()', ''), '[]', ''), '{}', '')
    WHERE brackets = NEW.brackets;
END;

UPDATE "matching-brackets"
SET brackets = (
    WITH cnt(n) AS (
        SELECT 1
        UNION ALL
        SELECT n + 1 FROM cnt WHERE n <= LENGTH(input)
    )

    -- clean the input to only have ()[]{} characters
    SELECT group_concat(SUBSTR(input, n, 1), '')
    FROM cnt
    WHERE '()[]{}' LIKE ('%' || SUBSTR(input, n, 1) || '%')
);

UPDATE "matching-brackets"
SET result = (brackets = '');

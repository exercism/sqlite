ALTER TABLE luhn
ADD luhn_sum INT DEFAULT 0;
ALTER TABLE luhn
ADD result_string TEXT;

CREATE VIEW cleaned_up (value, invalid_chars, no_spaces)
AS
    SELECT 
        value,
        value GLOB '*[^0-9 ]*',
        REPLACE(value, ' ', '')
    FROM luhn;

PRAGMA recursive_triggers = ON;

CREATE TRIGGER IF NOT EXISTS update_luhn
	AFTER UPDATE
    ON luhn
    WHEN LENGTH(NEW.result_string) > 0
BEGIN
	UPDATE luhn
    SET luhn_sum = luhn_sum + SUBSTR(NEW.result_string, -1, 1) + IIF(LENGTH(NEW.result_string) > 1,
                                                                    IIF(SUBSTR(NEW.result_string, -2, 1) > '4',
                                                                        2 * SUBSTR(NEW.result_string, -2, 1) - 9,
                                                                        2 * SUBSTR(NEW.result_string, -2, 1)),
                                                                    0),
        result_string = SUBSTR(NEW.result_string, 1, LENGTH(NEW.result_string) - 2)
    WHERE result_string = NEW.result_string;
END;


UPDATE luhn
SET result = False
WHERE value GLOB '*[^0-9 ]*' OR LENGTH(REPLACE(value, ' ', '')) <= 1;

UPDATE luhn
SET result_string = REPLACE(value, ' ', '')
WHERE NOT value GLOB '*[^0-9 ]*' AND LENGTH(REPLACE(value, ' ', '')) > 1;

UPDATE luhn
SET result = (luhn_sum % 10 = 0)
WHERE NOT value GLOB '*[^0-9 ]*' AND LENGTH(REPLACE(value, ' ', '')) > 1;

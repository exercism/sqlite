ALTER TABLE "roman-numerals"
ADD temp_num TEXT DEFAULT '';

PRAGMA recursive_triggers = ON;

CREATE TRIGGER IF NOT EXISTS update_roman_numerals
    AFTER UPDATE
    ON "roman-numerals"
    WHEN LENGTH(NEW.temp_num) > 0
BEGIN
    UPDATE "roman-numerals"
    SET result =
        -- we encode the roman numerals in base 10
        -- to add a digit, we translate IVXLC => XLCDM (multiply by ten)
        -- and then add the digit at the end

        REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(result, 'C', 'M'), 'L', 'D'), 'X', 'C'), 'V', 'L'), 'I', 'X') ||
        CASE SUBSTR(temp_num, 1, 1)
        WHEN '0' THEN ''
        WHEN '1' THEN 'I'
        WHEN '2' THEN 'II'
        WHEN '3' THEN 'III'
        WHEN '4' THEN 'IV'
        WHEN '5' THEN 'V'
        WHEN '6' THEN 'VI'
        WHEN '7' THEN 'VII'
        WHEN '8' THEN 'VIII'
        WHEN '9' THEN 'IX'
        END,
        temp_num = SUBSTR(temp_num, 2)
    WHERE temp_num = NEW.temp_num;
END;

UPDATE "roman-numerals"
SET temp_num = number || '';

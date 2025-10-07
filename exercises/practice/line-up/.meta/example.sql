UPDATE "line-up"
SET
  result = PRINTF(
    '%s, you are the %s customer we serve today. Thank you!',
    name,
    CASE
      WHEN number % 10 = 1
      AND number % 100 != 11 THEN number || 'st'
      WHEN number % 10 = 2
      AND number % 100 != 12 THEN number || 'nd'
      WHEN number % 10 = 3
      AND number % 100 != 13 THEN number || 'rd'
      ELSE number || 'th'
    END
  );

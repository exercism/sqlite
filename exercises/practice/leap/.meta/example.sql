UPDATE leap
SET
  is_leap = 1
WHERE
  year % 4 = 0
  AND (
    year % 100 != 0
    OR year % 400 = 0
  );

UPDATE grains
SET
  result = POWER(2, square - 1)
WHERE
  task = 'single-square';

UPDATE grains
SET
  result = POWER(2, 64) - 1
WHERE
  task = 'total';

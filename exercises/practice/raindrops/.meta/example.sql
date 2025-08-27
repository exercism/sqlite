UPDATE raindrops
SET
  sound = '';

UPDATE raindrops
SET
  sound = sound || 'Pling'
WHERE
  number % 3 == 0;

UPDATE raindrops
SET
  sound = sound || 'Plang'
WHERE
  number % 5 == 0;

UPDATE raindrops
SET
  sound = sound || 'Plong'
WHERE
  number % 7 == 0;

UPDATE raindrops
SET
  sound = number
WHERE
  sound = '';

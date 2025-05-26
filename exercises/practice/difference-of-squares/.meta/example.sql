UPDATE 'difference-of-squares'
SET result = number * number * (number + 1) * (number + 1) / 4
WHERE property = 'squareOfSum';

UPDATE 'difference-of-squares'
SET result = number * (number + 1) * (2 * number + 1) / 6
WHERE property = 'sumOfSquares';

UPDATE 'difference-of-squares'
SET result = number * (number + 1) * (3 * number + 2) * (number - 1) / 12
WHERE property = 'differenceOfSquares';

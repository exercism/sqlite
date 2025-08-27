UPDATE triangle
SET
  result = FALSE
WHERE
  0 IN (side_a, side_b, side_c)
  OR side_a + side_b < side_c
  OR side_b + side_c < side_a
  OR side_a + side_c < side_b;

UPDATE triangle
SET
  result = (
    side_a = side_b
    AND side_a = side_c
  )
WHERE
  property = 'equilateral'
  AND result ISNULL;

UPDATE triangle
SET
  result = (
    side_a = side_b
    OR side_a = side_c
    OR side_b = side_c
  )
WHERE
  property = 'isosceles'
  AND result ISNULL;

UPDATE triangle
SET
  result = (
    side_a != side_b
    AND side_a != side_c
    AND side_b != side_c
  )
WHERE
  property = 'scalene'
  AND result ISNULL;

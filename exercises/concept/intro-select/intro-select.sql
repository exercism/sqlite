SELECT * FROM weather_readings;

SELECT location, temperature FROM weather_readings;

-- This one will fail on purpose
SELECT 'Hello, world.' AS say_hi;

SELECT * FROM weather_readings WHERE location = 'Seattle';

SELECT * FROM weather_readings WHERE humidity BETWEEN 60 AND 70;

SELECT location FROM weather_readings;

SELECT DISTINCT location FROM weather_readings;

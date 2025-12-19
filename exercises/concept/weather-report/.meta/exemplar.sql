CREATE TABLE all_data AS
    -- Task 1. Select all records.
    SELECT * FROM weather_readings
;

CREATE TABLE location_and_temperature AS
    -- Task 2. Select only location and temperature data.
    SELECT location, temperature FROM weather_readings
;

CREATE TABLE seattle AS
    -- Task 3. Select all data for Seattle.
    SELECT * FROM weather_readings
    WHERE location = "Seattle"
;

CREATE TABLE limited_wind_speed AS
    -- Task 4. Select all data where the wind speed is between 5 and 15 miles per hour.
    SELECT * FROM weather_readings
    WHERE wind_speed BETWEEN 5 AND 15
;

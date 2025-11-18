-- TODO: Surround each task in a CREATE TABLE

CREATE TABLE all_data AS
    -- Task 1. Select all records.
    SELECT * FROM weather_readings
;

CREATE TABLE location_and_temperature AS
    -- Task 2. Select only location and temperature data.
    -- Expect failure
    SELECT temperature FROM weather_readings
;

CREATE TABLE hello AS
    -- Task 3. Say hello!
    -- Expect failure
    SELECT 'Goodbye, Mars.'
;

CREATE TABLE seattle AS
    -- Task 4. Select all data for Seattle.
    SELECT * FROM weather_readings WHERE location = 'Seattle'
;

CREATE TABLE limited_humidity AS
    -- Task 5. Select all data where the humidity is between 60% and 70%.
    SELECT * FROM weather_readings WHERE humidity BETWEEN 60 AND 70
;

CREATE TABLE location AS
    -- Task 6. Select only location data.
    SELECT location FROM weather_readings
;

CREATE TABLE unique_location AS
    -- Task 7. Select only unique location data.
    SELECT DISTINCT location FROM weather_readings
;

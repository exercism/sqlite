DROP TABLE IF EXISTS test_data;
CREATE TABLE test_data (
    task_number INTEGER,
    slug,
    description
);

INSERT INTO test_data (slug, description, task_number) VALUES
    ('all_data', 'All data', 1),
    ('location_and_temp', 'Just location and temperature', 2),
    ('hello', 'Hello, world', 3),
    ('seattle', 'Just Seattle data', 4),
    ('limited_humidity', 'Data with humidity within range', 5),
    ('location', 'Just location', 6),
    ('unique_location', 'Just unique locaations', 7);


DROP TABLE IF EXISTS all_data_expected;
CREATE TABLE all_data_expected AS
    SELECT * FROM weather_readings
;

DROP TABLE IF EXISTS location_and_temperature_expected;
CREATE TABLE location_and_temperature_expected AS
    SELECT location, temperature FROM weather_readings
;

DROP TABLE IF EXISTS hello_expected;
CREATE TABLE hello_expected AS
    SELECT 'Hello, world.'
;

DROP TABLE IF EXISTS seattle_expected;
CREATE TABLE seattle_expected AS
    SELECT * FROM weather_readings WHERE location = 'Seattle'
;

DROP TABLE IF EXISTS limited_humidity_expected;
CREATE TABLE limited_humidity_expected AS
    SELECT * FROM weather_readings WHERE humidity BETWEEN 60 AND 70
;

DROP TABLE IF EXISTS location_expected;
CREATE TABLE location_expected AS
    SELECT location FROM weather_readings
;

DROP TABLE IF EXISTS unique_location_expected;
CREATE TABLE unique_location_expected AS
    SELECT DISTINCT location FROM weather_readings
;


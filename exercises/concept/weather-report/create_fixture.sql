DROP TABLE IF EXISTS weather_readings;
CREATE TABLE weather_readings (
  date        TEXT    NOT NULL,
  location    TEXT    NOT NULL,
  temperature INTEGER NOT NULL,
  wind_speed  INTEGER NOT NULL
);

.mode csv
.import ./data.csv weather_readings

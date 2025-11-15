DROP TABLE IF EXISTS tests;
CREATE TABLE IF NOT EXISTS tests (
  description TEXT NOT NULL,
  -- The following section is needed by the online test-runner
  status TEXT DEFAULT 'fail',
  message TEXT,
  output TEXT,
  test_code TEXT,
  task_id INTEGER DEFAULT NULL,
  -- Here are columns for the actual tests
  expected TEXT NOT NULL
);

INSERT INTO tests (description, expected)
VALUES
  ('ALL records => SELECT * FROM weather_readings', '[{"date":"2025-10-22","location":"Portland","temperature":53.1,"humidity":72},{"date":"2025-10-22","location":"Seattle","temperature":56.2,"humidity":66},{"date":"2025-10-22","location":"Boise","temperature":60.4,"humidity":55},{"date":"2025-10-23","location":"Portland","temperature":54.6,"humidity":70},{"date":"2025-10-23","location":"Seattle","temperature":57.8,"humidity":68},{"date":"2025-10-23","location":"Boise","temperature":62.0,"humidity":58}]'),
  ('Just location and temperature columns => SELECT location, temperature FROM weather_readings', '[{"location":"Portland","temperature":53.1},{"location":"Seattle","temperature":56.2},{"location":"Boise","temperature":60.4},{"location":"Portland","temperature":54.6},{"location":"Seattle","temperature":57.8},{"location":"Boise","temperature":62.0}]'),
  ('Without "FROM" => SELECT ''Hello, world.''', '[{"''Hello, world.''":"Hello, world."}]'),
  ('All records from Seatle location => SELECT * FROM weather_readings WHERE location = ''Seattle''', '[{"date":"2025-10-22","location":"Seattle","temperature":56.2,"humidity":66},{"date":"2025-10-23","location":"Seattle","temperature":57.8,"humidity":68}]'),
  ('All records where humity in range => SELECT * FROM weather_readings WHERE humidity BETWEEN 60 AND 70', '[{"date":"2025-10-22","location":"Seattle","temperature":56.2,"humidity":66},{"date":"2025-10-23","location":"Portland","temperature":54.6,"humidity":70},{"date":"2025-10-23","location":"Seattle","temperature":57.8,"humidity":68}]'),
  ('Just location column => SELECT location FROM weather_readings', '[{"location":"Portland"},{"location":"Seattle"},{"location":"Boise"},{"location":"Portland"},{"location":"Seattle"},{"location":"Boise"}]'),
  ('Only unique locations => SELECT DISTINCT location FROM weather_readings', '[{"location":"Portland"},{"location":"Seattle"},{"location":"Boise"}]');
;

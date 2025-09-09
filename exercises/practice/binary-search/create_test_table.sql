DROP TABLE IF EXISTS tests;
CREATE TABLE IF NOT EXISTS tests (
  -- uuid and description are taken from the test.toml file
  uuid TEXT PRIMARY KEY,
  description TEXT NOT NULL,
  -- The following section is needed by the online test-runner
  status TEXT DEFAULT 'fail',
  message TEXT,
  output TEXT,
  test_code TEXT,
  task_id INTEGER DEFAULT NULL,
  -- Here are columns for the actual tests
  array TEXT NOT NULL,          -- json array
  value INTEGER NOT NULL,
  expected_result INTEGER,
  expected_error TEXT
);

INSERT INTO tests (uuid, description, array, value, expected_result, expected_error)
VALUES
('b55c24a9-a98d-4379-a08c-2adcf8ebeee8', 'finds a value in an array with one element', '[6]', 6, 0, NULL),
('73469346-b0a0-4011-89bf-989e443d503d', 'finds a value in the middle of an array', '[1,3,4,6,8,9,11]', 6, 3, NULL),
('327bc482-ab85-424e-a724-fb4658e66ddb', 'finds a value at the beginning of an array', '[1,3,4,6,8,9,11]', 1, 0, NULL),
('f9f94b16-fe5e-472c-85ea-c513804c7d59', 'finds a value at the end of an array', '[1,3,4,6,8,9,11]', 11, 6, NULL),
('f0068905-26e3-4342-856d-ad153cadb338', 'finds a value in an array of odd length', '[1,3,5,8,13,21,34,55,89,144,233,377,634]', 144, 9, NULL),
('fc316b12-c8b3-4f5e-9e89-532b3389de8c', 'finds a value in an array of even length', '[1,3,5,8,13,21,34,55,89,144,233,377]', 21, 5, NULL),
('da7db20a-354f-49f7-a6a1-650a54998aa6', 'identifies that a value is not included in the array', '[1,3,4,6,8,9,11]', 7, NULL, 'value not in array'),
('95d869ff-3daf-4c79-b622-6e805c675f97', 'a value smaller than the array''s smallest value is not found', '[1,3,4,6,8,9,11]', 0, NULL, 'value not in array'),
('8b24ef45-6e51-4a94-9eac-c2bf38fdb0ba', 'a value larger than the array''s largest value is not found', '[1,3,4,6,8,9,11]', 13, NULL, 'value not in array'),
('f439a0fa-cf42-4262-8ad1-64bf41ce566a', 'nothing is found in an empty array', '[]', 1, NULL, 'value not in array'),
('2c353967-b56d-40b8-acff-ce43115eed64', 'nothing is found when the left and right bounds cross', '[1,2]', 0, NULL, 'value not in array');

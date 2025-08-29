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
  radicand INTEGER NOT NULL,
  expected INTEGER NOT NULL
);

INSERT INTO
  tests (uuid, description, radicand, expected)
VALUES
  (
    '9b748478-7b0a-490c-b87a-609dacf631fd',
    'root of 1',
    1,
    1
  ),
  (
    '7d3aa9ba-9ac6-4e93-a18b-2e8b477139bb',
    'root of 4',
    4,
    2
  ),
  (
    '6624aabf-3659-4ae0-a1c8-25ae7f33c6ef',
    'root of 25',
    25,
    5
  ),
  (
    '93beac69-265e-4429-abb1-94506b431f81',
    'root of 81',
    81,
    9
  ),
  (
    'fbddfeda-8c4f-4bc4-87ca-6991af35360e',
    'root of 196',
    196,
    14
  ),
  (
    'c03d0532-8368-4734-a8e0-f96a9eb7fc1d',
    'root of 65025',
    65025,
    255
  );

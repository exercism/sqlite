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
  number INTEGER NOT NULL,
  expected TEXT NOT NULL
);

INSERT INTO
  tests (uuid, description, number, expected)
VALUES
  (
    'b8496fbd-6778-468c-8054-648d03c4bb23',
    'wink for 1',
    1,
    'wink'
  ),
  (
    '83ec6c58-81a9-4fd1-bfaf-0160514fc0e3',
    'double blink for 10',
    2,
    'double blink'
  ),
  (
    '0e20e466-3519-4134-8082-5639d85fef71',
    'close your eyes for 100',
    4,
    'close your eyes'
  ),
  (
    'b339ddbb-88b7-4b7d-9b19-4134030d9ac0',
    'jump for 1000',
    8,
    'jump'
  ),
  (
    '40499fb4-e60c-43d7-8b98-0de3ca44e0eb',
    'combine two actions',
    3,
    'wink, double blink'
  ),
  (
    '9730cdd5-ef27-494b-afd3-5c91ad6c3d9d',
    'reverse two actions',
    19,
    'double blink, wink'
  ),
  (
    '0b828205-51ca-45cd-90d5-f2506013f25f',
    'reversing one action gives the same action',
    24,
    'jump'
  ),
  (
    '9949e2ac-6c9c-4330-b685-2089ab28b05f',
    'reversing no actions still gives no actions',
    16,
    ''
  ),
  (
    '23fdca98-676b-4848-970d-cfed7be39f81',
    'all possible actions',
    15,
    'wink, double blink, close your eyes, jump'
  ),
  (
    'ae8fe006-d910-4d6f-be00-54b7c3799e79',
    'reverse all possible actions',
    31,
    'jump, close your eyes, double blink, wink'
  ),
  (
    '3d36da37-b31f-4cdb-a396-d93a2ee1c4a5',
    'do nothing for zero',
    0,
    ''
  );

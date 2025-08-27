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
  strand1 TEXT NOT NULL,
  strand2 TEXT NOT NULL,
  expected_result INTEGER,
  expected_error TEXT
);

INSERT INTO
  tests (
    uuid,
    description,
    strand1,
    strand2,
    expected_result,
    expected_error
  )
VALUES
  (
    'f6dcb64f-03b0-4b60-81b1-3c9dbf47e887',
    'empty strands',
    '',
    '',
    0,
    null
  ),
  (
    '54681314-eee2-439a-9db0-b0636c656156',
    'single letter identical strands',
    'A',
    'A',
    0,
    null
  ),
  (
    '294479a3-a4c8-478f-8d63-6209815a827b',
    'single letter different strands',
    'G',
    'T',
    1,
    null
  ),
  (
    '9aed5f34-5693-4344-9b31-40c692fb5592',
    'long identical strands',
    'GGACTGAAATCTG',
    'GGACTGAAATCTG',
    0,
    null
  ),
  (
    'cd2273a5-c576-46c8-a52b-dee251c3e6e5',
    'long different strands',
    'GGACGGATTCTG',
    'AGGACGGATTCT',
    9,
    null
  ),
  (
    'b9228bb1-465f-4141-b40f-1f99812de5a8',
    'disallow first strand longer',
    'AATG',
    'AAA',
    null,
    'strands must be of equal length'
  ),
  (
    'dab38838-26bb-4fff-acbe-3b0a9bfeba2d',
    'disallow second strand longer',
    'ATA',
    'AGTG',
    null,
    'strands must be of equal length'
  ),
  (
    'b764d47c-83ff-4de2-ab10-6cfe4b15c0f3',
    'disallow empty first strand',
    '',
    'G',
    null,
    'strands must be of equal length'
  ),
  (
    '9ab9262f-3521-4191-81f5-0ed184a5aa89',
    'disallow empty second strand',
    'G',
    '',
    null,
    'strands must be of equal length'
  );

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
  input TEXT NOT NULL,
  slice_length INTEGER NOT NULL,
  expected_result TEXT,
  expected_error TEXT
);

INSERT INTO
  tests (
    uuid,
    description,
    input,
    slice_length,
    expected_result,
    expected_error
  )
VALUES
  (
    '7ae7a46a-d992-4c2a-9c15-a112d125ebad',
    'slices of one from one',
    '1',
    1,
    '1',
    NULL
  ),
  (
    '3143b71d-f6a5-4221-aeae-619f906244d2',
    'slices of one from two',
    '12',
    1,
    '1\n2',
    NULL
  ),
  (
    'dbb68ff5-76c5-4ccd-895a-93dbec6d5805',
    'slices of two',
    '35',
    2,
    '35',
    NULL
  ),
  (
    '19bbea47-c987-4e11-a7d1-e103442adf86',
    'slices of two overlap',
    '9142',
    2,
    '91\n14\n42',
    NULL
  ),
  (
    '8e17148d-ba0a-4007-a07f-d7f87015d84c',
    'slices can include duplicates',
    '777777',
    3,
    '777\n777\n777\n777',
    NULL
  ),
  (
    'bd5b085e-f612-4f81-97a8-6314258278b0',
    'slices of a long series',
    '918493904243',
    5,
    '91849\n18493\n84939\n49390\n93904\n39042\n90424\n04243',
    NULL
  ),
  (
    '6d235d85-46cf-4fae-9955-14b6efef27cd',
    'slice length is too large',
    '12345',
    6,
    NULL,
    'slice length cannot be greater than series length'
  ),
  (
    'd7957455-346d-4e47-8e4b-87ed1564c6d7',
    'slice length is way too large',
    '12345',
    42,
    NULL,
    'slice length cannot be greater than series length'
  ),
  (
    'd34004ad-8765-4c09-8ba1-ada8ce776806',
    'slice length cannot be zero',
    '12345',
    0,
    NULL,
    'slice length cannot be zero'
  ),
  (
    '10ab822d-8410-470a-a85d-23fbeb549e54',
    'slice length cannot be negative',
    '123',
    -1,
    NULL,
    'slice length cannot be negative'
  ),
  (
    'c7ed0812-0e4b-4bf3-99c4-28cbbfc246a2',
    'empty series is invalid',
    '',
    1,
    NULL,
    'series cannot be empty'
  );

UPDATE tests
SET
  expected_result = REPLACE(expected_result, '\n', CHAR(10));

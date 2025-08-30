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
  expected_result TEXT,
  expected_error TEXT
);

INSERT INTO
  tests (
    uuid,
    description,
    number,
    expected_result,
    expected_error
  )
VALUES
  (
    '163e8e86-7bfd-4ee2-bd68-d083dc3381a3',
    'Smallest perfect number is classified correctly',
    6,
    'perfect',
    NULL
  ),
  (
    '169a7854-0431-4ae0-9815-c3b6d967436d',
    'Medium perfect number is classified correctly',
    28,
    'perfect',
    NULL
  ),
  (
    'ee3627c4-7b36-4245-ba7c-8727d585f402',
    'Large perfect number is classified correctly',
    33550336,
    'perfect',
    NULL
  ),
  (
    '80ef7cf8-9ea8-49b9-8b2d-d9cb3db3ed7e',
    'Smallest abundant number is classified correctly',
    12,
    'abundant',
    NULL
  ),
  (
    '3e300e0d-1a12-4f11-8c48-d1027165ab60',
    'Medium abundant number is classified correctly',
    30,
    'abundant',
    NULL
  ),
  (
    'ec7792e6-8786-449c-b005-ce6dd89a772b',
    'Large abundant number is classified correctly',
    33550335,
    'abundant',
    NULL
  ),
  (
    'e610fdc7-2b6e-43c3-a51c-b70fb37413ba',
    'Smallest prime deficient number is classified correctly',
    2,
    'deficient',
    NULL
  ),
  (
    '0beb7f66-753a-443f-8075-ad7fbd9018f3',
    'Smallest non-prime deficient number is classified correctly',
    4,
    'deficient',
    NULL
  ),
  (
    '1c802e45-b4c6-4962-93d7-1cad245821ef',
    'Medium deficient number is classified correctly',
    32,
    'deficient',
    NULL
  ),
  (
    '47dd569f-9e5a-4a11-9a47-a4e91c8c28aa',
    'Large deficient number is classified correctly',
    33550337,
    'deficient',
    NULL
  ),
  (
    'a696dec8-6147-4d68-afad-d38de5476a56',
    'Edge case (no factors other than itself) is classified correctly',
    1,
    'deficient',
    NULL
  ),
  (
    '72445cee-660c-4d75-8506-6c40089dc302',
    'Zero is rejected (as it is not a positive integer)',
    0,
    NULL,
    'Classification is only possible for positive integers.'
  ),
  (
    '2d72ce2c-6802-49ac-8ece-c790ba3dae13',
    'Negative integer is rejected (as it is not a positive integer)',
    -1,
    NULL,
    'Classification is only possible for positive integers.'
  );

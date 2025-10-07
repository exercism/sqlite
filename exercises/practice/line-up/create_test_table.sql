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
  name TEXT NOT NULL,
  number INTEGER NOT NULL,
  expected TEXT NOT NULL
);

INSERT INTO
  tests (uuid, description, name, number, expected)
VALUES
  (
    '7760d1b8-4864-4db4-953b-0fa7c047dbc0',
    'format smallest non-exceptional ordinal numeral 4',
    'Gianna',
    4,
    'Gianna, you are the 4th customer we serve today. Thank you!'
  ),
  (
    'e8b7c715-6baa-4f7b-8fb3-2fa48044ab7a',
    'format greatest single digit non-exceptional ordinal numeral 9',
    'Maarten',
    9,
    'Maarten, you are the 9th customer we serve today. Thank you!'
  ),
  (
    'f370aae9-7ae7-4247-90ce-e8ff8c6934df',
    'format non-exceptional ordinal numeral 5',
    'Petronila',
    5,
    'Petronila, you are the 5th customer we serve today. Thank you!'
  ),
  (
    '37f10dea-42a2-49de-bb92-0b690b677908',
    'format non-exceptional ordinal numeral 6',
    'Attakullakulla',
    6,
    'Attakullakulla, you are the 6th customer we serve today. Thank you!'
  ),
  (
    'd8dfb9a2-3a1f-4fee-9dae-01af3600054e',
    'format non-exceptional ordinal numeral 7',
    'Kate',
    7,
    'Kate, you are the 7th customer we serve today. Thank you!'
  ),
  (
    '505ec372-1803-42b1-9377-6934890fd055',
    'format non-exceptional ordinal numeral 8',
    'Maximiliano',
    8,
    'Maximiliano, you are the 8th customer we serve today. Thank you!'
  ),
  (
    '8267072d-be1f-4f70-b34a-76b7557a47b9',
    'format exceptional ordinal numeral 1',
    'Mary',
    1,
    'Mary, you are the 1st customer we serve today. Thank you!'
  ),
  (
    '4d8753cb-0364-4b29-84b8-4374a4fa2e3f',
    'format exceptional ordinal numeral 2',
    'Haruto',
    2,
    'Haruto, you are the 2nd customer we serve today. Thank you!'
  ),
  (
    '8d44c223-3a7e-4f48-a0ca-78e67bf98aa7',
    'format exceptional ordinal numeral 3',
    'Henriette',
    3,
    'Henriette, you are the 3rd customer we serve today. Thank you!'
  ),
  (
    '6c4f6c88-b306-4f40-bc78-97cdd583c21a',
    'format smallest two digit non-exceptional ordinal numeral 10',
    'Alvarez',
    10,
    'Alvarez, you are the 10th customer we serve today. Thank you!'
  ),
  (
    'e257a43f-d2b1-457a-97df-25f0923fc62a',
    'format non-exceptional ordinal numeral 11',
    'Jacqueline',
    11,
    'Jacqueline, you are the 11th customer we serve today. Thank you!'
  ),
  (
    'bb1db695-4d64-457f-81b8-4f5a2107e3f4',
    'format non-exceptional ordinal numeral 12',
    'Juan',
    12,
    'Juan, you are the 12th customer we serve today. Thank you!'
  ),
  (
    '60a3187c-9403-4835-97de-4f10ebfd63e2',
    'format non-exceptional ordinal numeral 13',
    'Patricia',
    13,
    'Patricia, you are the 13th customer we serve today. Thank you!'
  ),
  (
    '2bdcebc5-c029-4874-b6cc-e9bec80d603a',
    'format exceptional ordinal numeral 21',
    'Washi',
    21,
    'Washi, you are the 21st customer we serve today. Thank you!'
  ),
  (
    '74ee2317-0295-49d2-baf0-d56bcefa14e3',
    'format exceptional ordinal numeral 62',
    'Nayra',
    62,
    'Nayra, you are the 62nd customer we serve today. Thank you!'
  ),
  (
    'b37c332d-7f68-40e3-8503-e43cbd67a0c4',
    'format exceptional ordinal numeral 100',
    'John',
    100,
    'John, you are the 100th customer we serve today. Thank you!'
  ),
  (
    '0375f250-ce92-4195-9555-00e28ccc4d99',
    'format exceptional ordinal numeral 101',
    'Zeinab',
    101,
    'Zeinab, you are the 101st customer we serve today. Thank you!'
  ),
  (
    '0d8a4974-9a8a-45a4-aca7-a9fb473c9836',
    'format non-exceptional ordinal numeral 112',
    'Knud',
    112,
    'Knud, you are the 112th customer we serve today. Thank you!'
  ),
  (
    '06b62efe-199e-4ce7-970d-4bf73945713f',
    'format exceptional ordinal numeral 123',
    'Yma',
    123,
    'Yma, you are the 123rd customer we serve today. Thank you!'
  );

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
  isbn TEXT NOT NULL,
  expected BOOL NOT NULL
);

INSERT INTO
  tests (uuid, description, isbn, expected)
VALUES
  (
    '0caa3eac-d2e3-4c29-8df8-b188bc8c9292',
    'valid isbn',
    '3-598-21508-8',
    True
  ),
  (
    '19f76b53-7c24-45f8-87b8-4604d0ccd248',
    'invalid isbn check digit',
    '3-598-21508-9',
    False
  ),
  (
    '4164bfee-fb0a-4a1c-9f70-64c6a1903dcd',
    'valid isbn with a check digit of 10',
    '3-598-21507-X',
    True
  ),
  (
    '3ed50db1-8982-4423-a993-93174a20825c',
    'check digit is a character other than X',
    '3-598-21507-A',
    False
  ),
  (
    '9416f4a5-fe01-4b61-a07b-eb75892ef562',
    'invalid check digit in isbn is not treated as zero',
    '4-598-21507-B',
    False
  ),
  (
    'c19ba0c4-014f-4dc3-a63f-ff9aefc9b5ec',
    'invalid character in isbn is not treated as zero',
    '3-598-P1581-X',
    False
  ),
  (
    '28025280-2c39-4092-9719-f3234b89c627',
    'X is only valid as a check digit',
    '3-598-2X507-9',
    False
  ),
  (
    '8005b57f-f194-44ee-88d2-a77ac4142591',
    'only one check digit is allowed',
    '3-598-21508-96',
    False
  ),
  (
    'fdb14c99-4cf8-43c5-b06d-eb1638eff343',
    'X is not substituted by the value 10',
    '3-598-2X507-5',
    False
  ),
  (
    'f6294e61-7e79-46b3-977b-f48789a4945b',
    'valid isbn without separating dashes',
    '3598215088',
    True
  ),
  (
    '185ab99b-3a1b-45f3-aeec-b80d80b07f0b',
    'isbn without separating dashes and X as check digit',
    '359821507X',
    True
  ),
  (
    '7725a837-ec8e-4528-a92a-d981dd8cf3e2',
    'isbn without check digit and dashes',
    '359821507',
    False
  ),
  (
    '47e4dfba-9c20-46ed-9958-4d3190630bdf',
    'too long isbn and no dashes',
    '3598215078X',
    False
  ),
  (
    '737f4e91-cbba-4175-95bf-ae630b41fb60',
    'too short isbn',
    '00',
    False
  ),
  (
    '5458a128-a9b6-4ff8-8afb-674e74567cef',
    'isbn without check digit',
    '3-598-21507',
    False
  ),
  (
    '70b6ad83-d0a2-4ca7-a4d5-a9ab731800f7',
    'check digit of X should not be used for 0',
    '3-598-21515-X',
    False
  ),
  (
    '94610459-55ab-4c35-9b93-ff6ea1a8e562',
    'empty isbn',
    '',
    False
  ),
  (
    '7bff28d4-d770-48cc-80d6-b20b3a0fb46c',
    'input is 9 characters',
    '134456729',
    False
  ),
  (
    'ed6e8d1b-382c-4081-8326-8b772c581fec',
    'invalid characters are not ignored after checking length',
    '3132P34035',
    False
  ),
  (
    'daad3e58-ce00-4395-8a8e-e3eded1cdc86',
    'invalid characters are not ignored before checking length',
    '3598P215088',
    False
  ),
  (
    'fb5e48d8-7c03-4bfb-a088-b101df16fdc3',
    'input is too long but contains a valid isbn',
    '98245726788',
    False
  );

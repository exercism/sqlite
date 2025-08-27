-- Setup test table and read in student solution:
.read ./test_setup.sql
-- Test cases:
INSERT INTO
  tests (uuid, name, input, expected)
VALUES
  (
    'empty string',
    'a0e97d2d-669e-47c7-8134-518a1e2c4555',
    '',
    1
  ),
  (
    'isogram with only lower case characters',
    '9a001b50-f194-4143-bc29-2af5ec1ef652',
    'isogram',
    1
  ),
  (
    'word with one duplicated character',
    '8ddb0ca3-276e-4f8b-89da-d95d5bae78a4',
    'eleven',
    0
  ),
  (
    'word with one duplicated character from the end of the alphabet',
    '6450b333-cbc2-4b24-a723-0b459b34fe18',
    'zzyzx',
    0
  ),
  (
    'longest reported english isogram',
    'a15ff557-dd04-4764-99e7-02cc1a385863',
    'subdermatoglyphic',
    1
  ),
  (
    'word with duplicated character in mixed case',
    'f1a7f6c7-a42f-4915-91d7-35b2ea11c92e',
    'Alphabet',
    0
  ),
  (
    'word with duplicated character in mixed case, lowercase first',
    '14a4f3c1-3b47-4695-b645-53d328298942',
    'alphAbet',
    0
  ),
  (
    'hypothetical isogrammic word with hyphen',
    '423b850c-7090-4a8a-b057-97f1cadd7c42',
    'thumbscrew-japingly',
    1
  ),
  (
    'hypothetical word with duplicated character following hyphen',
    '93dbeaa0-3c5a-45c2-8b25-428b8eacd4f2',
    'thumbscrew-jappingly',
    0
  ),
  (
    'isogram with duplicated hyphen',
    '36b30e5c-173f-49c6-a515-93a3e825553f',
    'six-year-old',
    1
  ),
  (
    'made-up name that is an isogram',
    'cdabafa0-c9f4-4c1f-b142-689c6ee17d93',
    'Emily Jung Schwartzkopf',
    1
  ),
  (
    'duplicated character in the middle',
    '5fc61048-d74e-48fd-bc34-abfc21552d4d',
    'accentor',
    0
  ),
  (
    'same first and last characters',
    '310ac53d-8932-47bc-bbb4-b2b94f25a83e',
    'angola',
    0
  ),
  (
    'word with duplicated character and with two hyphens',
    '0d0b8644-0a1e-4a31-a432-2b3ee270d847',
    'up-to-date',
    0
  );

-- Comparison of user input and the tests updates the status for each test:
UPDATE tests
SET
  status = 'pass'
FROM
  (
    SELECT
      phrase,
      is_isogram
    FROM
      isogram
  ) AS actual
WHERE
  (actual.phrase, actual.is_isogram) = (tests.input, tests.expected);

-- Write results and debug info:
.read ./test_reporter.sql

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
  question TEXT NOT NULL,
  expected_result INTEGER,
  expected_error TEXT
);

INSERT INTO
  tests (
    uuid,
    description,
    question,
    expected_result,
    expected_error
  )
VALUES
  (
    '88bf4b28-0de3-4883-93c7-db1b14aa806e',
    'just a number',
    'What is 5?',
    5,
    NULL
  ),
  (
    '18983214-1dfc-4ebd-ac77-c110dde699ce',
    'just a zero',
    'What is 0?',
    0,
    NULL
  ),
  (
    '607c08ee-2241-4288-916d-dae5455c87e6',
    'just a negative number',
    'What is -123?',
    -123,
    NULL
  ),
  (
    'bb8c655c-cf42-4dfc-90e0-152fcfd8d4e0',
    'addition',
    'What is 1 plus 1?',
    2,
    NULL
  ),
  (
    'bb9f2082-171c-46ad-ad4e-c3f72087c1b5',
    'addition with a left hand zero',
    'What is 0 plus 2?',
    2,
    NULL
  ),
  (
    '6fa05f17-405a-4742-80ae-5d1a8edb0d5d',
    'addition with a right hand zero',
    'What is 3 plus 0?',
    3,
    NULL
  ),
  (
    '79e49e06-c5ae-40aa-a352-7a3a01f70015',
    'more addition',
    'What is 53 plus 2?',
    55,
    NULL
  ),
  (
    'b345dbe0-f733-44e1-863c-5ae3568f3803',
    'addition with negative numbers',
    'What is -1 plus -10?',
    -11,
    NULL
  ),
  (
    'cd070f39-c4cc-45c4-97fb-1be5e5846f87',
    'large addition',
    'What is 123 plus 45678?',
    45801,
    NULL
  ),
  (
    '0d86474a-cd93-4649-a4fa-f6109a011191',
    'subtraction',
    'What is 4 minus -12?',
    16,
    NULL
  ),
  (
    '30bc8395-5500-4712-a0cf-1d788a529be5',
    'multiplication',
    'What is -3 multiplied by 25?',
    -75,
    NULL
  ),
  (
    '34c36b08-8605-4217-bb57-9a01472c427f',
    'division',
    'What is 33 divided by -3?',
    -11,
    NULL
  ),
  (
    'da6d2ce4-fb94-4d26-8f5f-b078adad0596',
    'multiple additions',
    'What is 1 plus 1 plus 1?',
    3,
    NULL
  ),
  (
    '7fd74c50-9911-4597-be09-8de7f2fea2bb',
    'addition and subtraction',
    'What is 1 plus 5 minus -2?',
    8,
    NULL
  ),
  (
    'b120ffd5-bad6-4e22-81c8-5512e8faf905',
    'multiple subtraction',
    'What is 20 minus 4 minus 13?',
    3,
    NULL
  ),
  (
    '4f4a5749-ef0c-4f60-841f-abcfaf05d2ae',
    'subtraction then addition',
    'What is 17 minus 6 plus 3?',
    14,
    NULL
  ),
  (
    '312d908c-f68f-42c9-aa75-961623cc033f',
    'multiple multiplication',
    'What is 2 multiplied by -2 multiplied by 3?',
    -12,
    NULL
  ),
  (
    '38e33587-8940-4cc1-bc28-bfd7e3966276',
    'addition and multiplication',
    'What is -3 plus 7 multiplied by -2?',
    -8,
    NULL
  ),
  (
    '3c854f97-9311-46e8-b574-92b60d17d394',
    'multiple division',
    'What is -12 divided by 2 divided by -3?',
    2,
    NULL
  ),
  (
    '3ad3e433-8af7-41ec-aa9b-97b42ab49357',
    'unknown operation',
    'What is 52 cubed?',
    NULL,
    'unknown operation'
  ),
  (
    '8a7e85a8-9e7b-4d46-868f-6d759f4648f8',
    'Non math question',
    'Who is the President of the United States?',
    NULL,
    'unknown operation'
  ),
  (
    '42d78b5f-dbd7-4cdb-8b30-00f794bb24cf',
    'reject problem missing an operand',
    'What is 1 plus?',
    NULL,
    'syntax error'
  ),
  (
    'c2c3cbfc-1a72-42f2-b597-246e617e66f5',
    'reject problem with no operands or operators',
    'What is?',
    NULL,
    'syntax error'
  ),
  (
    '4b3df66d-6ed5-4c95-a0a1-d38891fbdab6',
    'reject two operations in a row',
    'What is 1 plus plus 2?',
    NULL,
    'syntax error'
  ),
  (
    '6abd7a50-75b4-4665-aa33-2030fd08bab1',
    'reject two numbers in a row',
    'What is 1 plus 2 1?',
    NULL,
    'syntax error'
  ),
  (
    '10a56c22-e0aa-405f-b1d2-c642d9c4c9de',
    'reject postfix notation',
    'What is 1 2 plus?',
    NULL,
    'syntax error'
  ),
  (
    '0035bc63-ac43-4bb5-ad6d-e8651b7d954e',
    'reject prefix notation',
    'What is plus 1 2?',
    NULL,
    'syntax error'
  );

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
  plaintext TEXT NOT NULL,
  expected TEXT NOT NULL
);

INSERT INTO
  tests (uuid, description, plaintext, expected)
VALUES
  (
    '407c3837-9aa7-4111-ab63-ec54b58e8e9f',
    'empty plaintext results in an empty ciphertext',
    '',
    ''
  ),
  (
    'aad04a25-b8bb-4304-888b-581bea8e0040',
    'normalization results in empty plaintext',
    '... --- ...',
    ''
  ),
  (
    '64131d65-6fd9-4f58-bdd8-4a2370fb481d',
    'Lowercase',
    'A',
    'a'
  ),
  (
    '63a4b0ed-1e3c-41ea-a999-f6f26ba447d6',
    'Remove spaces',
    '  b ',
    'b'
  ),
  (
    '1b5348a1-7893-44c1-8197-42d48d18756c',
    'Remove punctuation',
    '@1,%!',
    '1'
  ),
  (
    '8574a1d3-4a08-4cec-a7c7-de93a164f41a',
    '9 character plaintext results in 3 chunks of 3 characters',
    'This is fun!',
    'tsf hiu isn'
  ),
  (
    'a65d3fa1-9e09-43f9-bcec-7a672aec3eae',
    '8 character plaintext results in 3 chunks, the last one with a trailing space',
    'Chill out.',
    'clu hlt io '
  ),
  (
    '33fd914e-fa44-445b-8f38-ff8fbc9fe6e6',
    '54 character plaintext results in 8 chunks, the last two with trailing spaces',
    'If man was meant to stay on the ground, god would have given us roots.',
    'imtgdvs fearwer mayoogo anouuio ntnnlvt wttddes aohghn  sseoau '
  );

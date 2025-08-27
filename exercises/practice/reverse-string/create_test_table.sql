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
  expected TEXT NOT NULL
);

INSERT INTO
  tests (uuid, description, input, expected)
VALUES
  (
    'c3b7d806-dced-49ee-8543-933fd1719b1c',
    'an empty string',
    '',
    ''
  ),
  (
    '01ebf55b-bebb-414e-9dec-06f7bb0bee3c',
    'a word',
    'robot',
    'tobor'
  ),
  (
    '0f7c07e4-efd1-4aaa-a07a-90b49ce0b746',
    'a capitalized word',
    'Ramen',
    'nemaR'
  ),
  (
    '71854b9c-f200-4469-9f5c-1e8e5eff5614',
    'a sentence with punctuation',
    'I''m hungry!',
    '!yrgnuh m''I'
  ),
  (
    '1f8ed2f3-56f3-459b-8f3e-6d8d654a1f6c',
    'a palindrome',
    'racecar',
    'racecar'
  ),
  (
    'b9e7dec1-c6df-40bd-9fa3-cd7ded010c4c',
    'an even-sized word',
    'drawer',
    'reward'
  );

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
  strings TEXT NOT NULL, -- json array
  expected TEXT NOT NULL
);

INSERT INTO
  tests (uuid, description, strings, expected)
VALUES
  (
    'e974b73e-7851-484f-8d6d-92e07fe742fc',
    'zero pieces',
    '[]',
    ''
  ),
  (
    '2fcd5f5e-8b82-4e74-b51d-df28a5e0faa4',
    'one piece',
    '["nail"]',
    'And all for the want of a nail.'
  ),
  (
    'd9d0a8a1-d933-46e2-aa94-eecf679f4b0e',
    'two pieces',
    '["nail","shoe"]',
    'For want of a nail the shoe was lost.\nAnd all for the want of a nail.'
  ),
  (
    'c95ef757-5e94-4f0d-a6cb-d2083f5e5a83',
    'three pieces',
    '["nail","shoe","horse"]',
    'For want of a nail the shoe was lost.\nFor want of a shoe the horse was lost.\nAnd all for the want of a nail.'
  ),
  (
    '433fb91c-35a2-4d41-aeab-4de1e82b2126',
    'full proverb',
    '["nail","shoe","horse","rider","message","battle","kingdom"]',
    'For want of a nail the shoe was lost.\nFor want of a shoe the horse was lost.\nFor want of a horse the rider was lost.\nFor want of a rider the message was lost.\nFor want of a message the battle was lost.\nFor want of a battle the kingdom was lost.\nAnd all for the want of a nail.'
  ),
  (
    'c1eefa5a-e8d9-41c7-91d4-99fab6d6b9f7',
    'four pieces modernized',
    '["pin","gun","soldier","battle"]',
    'For want of a pin the gun was lost.\nFor want of a gun the soldier was lost.\nFor want of a soldier the battle was lost.\nAnd all for the want of a pin.'
  );

UPDATE tests
SET
  expected = REPLACE(expected, '\n', CHAR(10));

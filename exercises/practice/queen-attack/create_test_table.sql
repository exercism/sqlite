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
  property TEXT NOT NULL,
  input TEXT NOT NULL,          -- json object
  expected_result BOOLEAN,
  expected_error TEXT
);

INSERT INTO tests (uuid, description, property, input, expected_result, expected_error)
VALUES
('3ac4f735-d36c-44c4-a3e2-316f79704203', 'queen with a valid position', 'create', '{"queen":{"position":{"row":2,"column":2}}}', 1, NULL),
('4e812d5d-b974-4e38-9a6b-8e0492bfa7be', 'queen must have positive row', 'create', '{"queen":{"position":{"row":-2,"column":2}}}', NULL, 'row not positive'),
('f07b7536-b66b-4f08-beb9-4d70d891d5c8', 'queen must have row on board', 'create', '{"queen":{"position":{"row":8,"column":4}}}', NULL, 'row not on board'),
('15a10794-36d9-4907-ae6b-e5a0d4c54ebe', 'queen must have positive column', 'create', '{"queen":{"position":{"row":2,"column":-2}}}', NULL, 'column not positive'),
('6907762d-0e8a-4c38-87fb-12f2f65f0ce4', 'queen must have column on board', 'create', '{"queen":{"position":{"row":4,"column":8}}}', NULL, 'column not on board'),
('33ae4113-d237-42ee-bac1-e1e699c0c007', 'cannot attack', 'canAttack', '{"white_queen":{"position":{"row":2,"column":4}},"black_queen":{"position":{"row":6,"column":6}}}', 0, NULL),
('eaa65540-ea7c-4152-8c21-003c7a68c914', 'can attack on same row', 'canAttack', '{"white_queen":{"position":{"row":2,"column":4}},"black_queen":{"position":{"row":2,"column":6}}}', 1, NULL),
('bae6f609-2c0e-4154-af71-af82b7c31cea', 'can attack on same column', 'canAttack', '{"white_queen":{"position":{"row":4,"column":5}},"black_queen":{"position":{"row":2,"column":5}}}', 1, NULL),
('0e1b4139-b90d-4562-bd58-dfa04f1746c7', 'can attack on first diagonal', 'canAttack', '{"white_queen":{"position":{"row":2,"column":2}},"black_queen":{"position":{"row":0,"column":4}}}', 1, NULL),
('ff9b7ed4-e4b6-401b-8d16-bc894d6d3dcd', 'can attack on second diagonal', 'canAttack', '{"white_queen":{"position":{"row":2,"column":2}},"black_queen":{"position":{"row":3,"column":1}}}', 1, NULL),
('0a71e605-6e28-4cc2-aa47-d20a2e71037a', 'can attack on third diagonal', 'canAttack', '{"white_queen":{"position":{"row":2,"column":2}},"black_queen":{"position":{"row":1,"column":1}}}', 1, NULL),
('0790b588-ae73-4f1f-a968-dd0b34f45f86', 'can attack on fourth diagonal', 'canAttack', '{"white_queen":{"position":{"row":1,"column":7}},"black_queen":{"position":{"row":0,"column":6}}}', 1, NULL),
('543f8fd4-2597-4aad-8d77-cbdab63619f8', 'cannot attack if falling diagonals are only the same when reflected across the longest falling diagonal', 'canAttack', '{"white_queen":{"position":{"row":4,"column":1}},"black_queen":{"position":{"row":2,"column":5}}}', 0, NULL);

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
  property TEST NOT NULL,
  msg TEXT NOT NULL,
  rails INTEGER NOT NULL,
  expected TEXT NOT NULL
);

INSERT INTO tests (uuid, description, property, msg, rails, expected)
VALUES
('46dc5c50-5538-401d-93a5-41102680d068', 'encode with two rails', 'encode', 'XOXOXOXOXOXOXOXOXO', 2, 'XXXXXXXXXOOOOOOOOO'),
('25691697-fbd8-4278-8c38-b84068b7bc29', 'encode with three rails', 'encode', 'WEAREDISCOVEREDFLEEATONCE', 3, 'WECRLTEERDSOEEFEAOCAIVDEN'),
('384f0fea-1442-4f1a-a7c4-5cbc2044002c', 'encode with ending in the middle', 'encode', 'EXERCISES', 4, 'ESXIEECSR'),
('cd525b17-ec34-45ef-8f0e-4f27c24a7127', 'decode with three rails', 'decode', 'TEITELHDVLSNHDTISEIIEA', 3, 'THEDEVILISINTHEDETAILS'),
('dd7b4a98-1a52-4e5c-9499-cbb117833507', 'decode with five rails', 'decode', 'EIEXMSMESAORIWSCE', 5, 'EXERCISMISAWESOME'),
('93e1ecf4-fac9-45d9-9cd2-591f47d3b8d3', 'decode with six rails', 'decode', '133714114238148966225439541018335470986172518171757571896261', 6, '112358132134558914423337761098715972584418167651094617711286');

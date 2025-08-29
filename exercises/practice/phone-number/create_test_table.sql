DROP TABLE IF EXISTS tests;
CREATE TABLE IF NOT EXISTS tests (
  -- uuid and description are taken from the test.toml file
  uuid            TEXT PRIMARY KEY    ,
  description     TEXT NOT NULL       ,
  -- The following section is needed by the online test-runner
  status          TEXT DEFAULT 'fail' ,
  message         TEXT                ,
  output          TEXT                ,
  test_code       TEXT                ,
  task_id         INTEGER DEFAULT NULL,
  -- Here are columns for the actual tests
  phrase          TEXT NOT NULL       ,
  expected_result TEXT                ,
  expected_error  TEXT
);

INSERT INTO tests (uuid, description, phrase, expected_result, expected_error)
VALUES
  ('79666dce-e0f1-46de-95a1-563802913c35', 'cleans the number', '(223) 456-7890', '2234567890', NULL),
  ('c360451f-549f-43e4-8aba-fdf6cb0bf83f', 'cleans numbers with dots', '223.456.7890', '2234567890', NULL),
  ('08f94c34-9a37-46a2-a123-2a8e9727395d', 'cleans numbers with multiple spaces', '223 456   7890   ', '2234567890', NULL),
  ('2de74156-f646-42b5-8638-0ef1d8b58bc2', 'invalid when 9 digits', '123456789', NULL, 'must not be fewer than 10 digits'),
  ('57061c72-07b5-431f-9766-d97da7c4399d', 'invalid when 11 digits does not start with a 1', '22234567890', NULL, '11 digits must start with 1'),
  ('9962cbf3-97bb-4118-ba9b-38ff49c64430', 'valid when 11 digits and starting with 1', '12234567890', '2234567890', NULL),
  ('fa724fbf-054c-4d91-95da-f65ab5b6dbca', 'valid when 11 digits and starting with 1 even with punctuation', '+1 (223) 456-7890', '2234567890', NULL),
  ('4a1509b7-8953-4eec-981b-c483358ff531', 'invalid when more than 11 digits', '321234567890', NULL, 'must not be greater than 11 digits'),
  ('eb8a1fc0-64e5-46d3-b0c6-33184208e28a', 'invalid with letters', '523-abc-7890', NULL, 'letters not permitted'),
  ('065f6363-8394-4759-b080-e6c8c351dd1f', 'invalid with punctuations', '523-@:!-7890', NULL, 'punctuations not permitted'),
  ('d77d07f8-873c-4b17-8978-5f66139bf7d7', 'invalid if area code starts with 0', '(023) 456-7890', NULL, 'area code cannot start with zero'),
  ('c7485cfb-1e7b-4081-8e96-8cdb3b77f15e', 'invalid if area code starts with 1', '(123) 456-7890', NULL, 'area code cannot start with one'),
  ('4d622293-6976-413d-b8bf-dd8a94d4e2ac', 'invalid if exchange code starts with 0', '(223) 056-7890', NULL, 'exchange code cannot start with zero'),
  ('4cef57b4-7d8e-43aa-8328-1e1b89001262', 'invalid if exchange code starts with 1', '(223) 156-7890', NULL, 'exchange code cannot start with one'),
  ('9925b09c-1a0d-4960-a197-5d163cbe308c', 'invalid if area code starts with 0 on valid 11-digit number', '1 (023) 456-7890', NULL, 'area code cannot start with zero'),
  ('3f809d37-40f3-44b5-ad90-535838b1a816', 'invalid if area code starts with 1 on valid 11-digit number', '1 (123) 456-7890', NULL, 'area code cannot start with one'),
  ('e08e5532-d621-40d4-b0cc-96c159276b65', 'invalid if exchange code starts with 0 on valid 11-digit number', '1 (223) 056-7890', NULL, 'exchange code cannot start with zero'),
  ('57b32f3d-696a-455c-8bf1-137b6d171cdf', 'invalid if exchange code starts with 1 on valid 11-digit number', '1 (223) 156-7890', NULL, 'exchange code cannot start with one');

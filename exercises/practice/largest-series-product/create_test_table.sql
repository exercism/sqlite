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
  digits TEXT NOT NULL,
  span INTEGER NOT NULL,
  expected_result INTEGER,
  expected_error TEXT
);

INSERT INTO tests (uuid, description, digits, span, expected_result, expected_error)
VALUES
('7c82f8b7-e347-48ee-8a22-f672323324d4', 'finds the largest product if span equals length', '29', 2, 18, NULL),
('88523f65-21ba-4458-a76a-b4aaf6e4cb5e', 'can find the largest product of 2 with numbers in order', '0123456789', 2, 72, NULL),
('f1376b48-1157-419d-92c2-1d7e36a70b8a', 'can find the largest product of 2', '576802143', 2, 48, NULL),
('46356a67-7e02-489e-8fea-321c2fa7b4a4', 'can find the largest product of 3 with numbers in order', '0123456789', 3, 504, NULL),
('a2dcb54b-2b8f-4993-92dd-5ce56dece64a', 'can find the largest product of 3', '1027839564', 3, 270, NULL),
('673210a3-33cd-4708-940b-c482d7a88f9d', 'can find the largest product of 5 with numbers in order', '0123456789', 5, 15120, NULL),
('02acd5a6-3bbf-46df-8282-8b313a80a7c9', 'can get the largest product of a big number', '73167176531330624919225119674426574742355349194934', 6, 23520, NULL),
('76dcc407-21e9-424c-a98e-609f269622b5', 'reports zero if the only digits are zero', '0000', 2, 0, NULL),
('6ef0df9f-52d4-4a5d-b210-f6fae5f20e19', 'reports zero if all spans include zero', '99099', 3, 0, NULL),
('0ae1ce53-d9ba-41bb-827f-2fceb64f058b', 'rejects span longer than string length', '123', 4, NULL, 'span must not exceed string length'),
('06bc8b90-0c51-4c54-ac22-3ec3893a079e', 'reports 1 for empty string and empty product (0 span)', '', 0, 1, NULL),
('3ec0d92e-f2e2-4090-a380-70afee02f4c0', 'reports 1 for nonempty string and empty product (0 span)', '123', 0, 1, NULL),
('6cf66098-a6af-4223-aab1-26aeeefc7402', 'rejects empty string and nonzero span', '', 1, NULL, 'span must not exceed string length'),
('7a38f2d6-3c35-45f6-8d6f-12e6e32d4d74', 'rejects invalid character in digits', '1234a5', 2, NULL, 'digits input must only contain digits'),
('c859f34a-9bfe-4897-9c2f-6d7f8598e7f0', 'rejects negative span', '12345', -1, NULL, 'span must not be negative');

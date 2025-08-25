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
    number INTEGER NOT NULL,
    expected_result TEXT,
    expected_error TEXT
);

INSERT INTO tests (uuid, description, number, expected_result, expected_error)
    VALUES
        ('5d22a120-ba0c-428c-bd25-8682235d83e8', 'zero', 0, 'zero', NULL),
        ('9b5eed77-dbf6-439d-b920-3f7eb58928f6', 'one', 1, 'one', NULL),
        ('7c499be1-612e-4096-a5e1-43b2f719406d', 'fourteen', 14, 'fourteen', NULL),
        ('f541dd8e-f070-4329-92b4-b7ce2fcf06b4', 'twenty', 20, 'twenty', NULL),
        ('d78601eb-4a84-4bfa-bf0e-665aeb8abe94', 'twenty-two', 22, 'twenty-two', NULL),
        ('f010d4ca-12c9-44e9-803a-27789841adb1', 'thirty', 30, 'thirty', NULL),
        ('738ce12d-ee5c-4dfb-ad26-534753a98327', 'ninety-nine', 99, 'ninety-nine', NULL),
        ('e417d452-129e-4056-bd5b-6eb1df334dce', 'one hundred', 100, 'one hundred', NULL),
        ('d6924f30-80ba-4597-acf6-ea3f16269da8', 'one hundred twenty-three', 123, 'one hundred twenty-three', NULL),
        ('2f061132-54bc-4fd4-b5df-0a3b778959b9', 'two hundred', 200, 'two hundred', NULL),
        ('feed6627-5387-4d38-9692-87c0dbc55c33', 'nine hundred ninety-nine', 999, 'nine hundred ninety-nine', NULL),
        ('3d83da89-a372-46d3-b10d-de0c792432b3', 'one thousand', 1000, 'one thousand', NULL),
        ('865af898-1d5b-495f-8ff0-2f06d3c73709', 'one thousand two hundred thirty-four', 1234, 'one thousand two hundred thirty-four', NULL),
        ('b6a3f442-266e-47a3-835d-7f8a35f6cf7f', 'one million', 1000000, 'one million', NULL),
        ('2cea9303-e77e-4212-b8ff-c39f1978fc70', 'one million two thousand three hundred forty-five', 1002345, 'one million two thousand three hundred forty-five', NULL),
        ('3e240eeb-f564-4b80-9421-db123f66a38f', 'one billion', 1000000000, 'one billion', NULL),
        ('9a43fed1-c875-4710-8286-5065d73b8a9e', 'a big number', 987654321123, 'nine hundred eighty-seven billion six hundred fifty-four million three hundred twenty-one thousand one hundred twenty-three', NULL),
        ('49a6a17b-084e-423e-994d-a87c0ecc05ef', 'numbers below zero are out of range', -1, NULL, 'input out of range'),
        ('4d6492eb-5853-4d16-9d34-b0f61b261fd9', 'numbers above 999,999,999,999 are out of range', 1000000000000, NULL, 'input out of range');

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
    expected_result TEXT,
    expected_error TEXT
);

INSERT INTO tests (uuid, description, input, expected_result, expected_error)
VALUES
('5ee54e1a-b554-4bf3-a056-9a7976c3f7e8', 'Recognizes 0', ' _ \n| |\n|_|\n   ', '0', NULL),
('027ada25-17fd-4d78-aee6-35a19623639d', 'Recognizes 1', '   \n  |\n  |\n   ', '1', NULL),
('3cce2dbd-01d9-4f94-8fae-419a822e89bb', 'Unreadable but correctly sized inputs return ?', '   \n  _\n  |\n   ', '?', NULL),
('cb19b733-4e36-4cf9-a4a1-6e6aac808b9a', 'Input with a number of lines that is not a multiple of four raises an error', ' _ \n| |\n   ', NULL, 'Number of input lines is not a multiple of four'),
('235f7bd1-991b-4587-98d4-84206eec4cc6', 'Input with a number of columns that is not a multiple of three raises an error', '    \n   |\n   |\n    ', NULL, 'Number of input columns is not a multiple of three'),
('4a841794-73c9-4da9-a779-1f9837faff66', 'Recognizes 110101100', '       _     _        _  _ \n  |  || |  || |  |  || || |\n  |  ||_|  ||_|  |  ||_||_|\n                           ', '110101100', NULL),
('70c338f9-85b1-4296-a3a8-122901cdfde8', 'Garbled numbers in a string are replaced with ?', '       _     _           _ \n  |  || |  || |     || || |\n  |  | _|  ||_|  |  ||_||_|\n                           ', '11?10?1?0', NULL),
('ea494ff4-3610-44d7-ab7e-72fdef0e0802', 'Recognizes 2', ' _ \n _|\n|_ \n   ', '2', NULL),
('1acd2c00-412b-4268-93c2-bd7ff8e05a2c', 'Recognizes 3', ' _ \n _|\n _|\n   ', '3', NULL),
('eaec6a15-be17-4b6d-b895-596fae5d1329', 'Recognizes 4', '   \n|_|\n  |\n   ', '4', NULL),
('440f397a-f046-4243-a6ca-81ab5406c56e', 'Recognizes 5', ' _ \n|_ \n _|\n   ', '5', NULL),
('f4c9cf6a-f1e2-4878-bfc3-9b85b657caa0', 'Recognizes 6', ' _ \n|_ \n|_|\n   ', '6', NULL),
('e24ebf80-c611-41bb-a25a-ac2c0f232df5', 'Recognizes 7', ' _ \n  |\n  |\n   ', '7', NULL),
('b79cad4f-e264-4818-9d9e-77766792e233', 'Recognizes 8', ' _ \n|_|\n|_|\n   ', '8', NULL),
('5efc9cfc-9227-4688-b77d-845049299e66', 'Recognizes 9', ' _ \n|_|\n _|\n   ', '9', NULL),
('f60cb04a-42be-494e-a535-3451c8e097a4', 'Recognizes string of decimal numbers', '    _  _     _  _  _  _  _  _ \n  | _| _||_||_ |_   ||_||_|| |\n  ||_  _|  | _||_|  ||_| _||_|\n                              ', '1234567890', NULL),
('b73ecf8b-4423-4b36-860d-3710bdb8a491', 'Numbers separated by empty lines are recognized. Lines are joined by commas.', '    _  _ \n  | _| _|\n  ||_  _|\n         \n    _  _ \n|_||_ |_ \n  | _||_|\n         \n _  _  _ \n  ||_||_|\n  ||_| _|\n         ', '123,456,789', NULL);

UPDATE tests SET input = REPLACE(input, '\n', CHAR(10));

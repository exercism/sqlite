DROP TABLE IF EXISTS tests;
CREATE TABLE IF NOT EXISTS tests (
    -- uuid and name are taken from the test.toml file
    uuid TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    -- The following section is needed by the online test-runner
    status TEXT DEFAULT 'fail',
    message TEXT,
    output TEXT,
    test_code TEXT,
    task_id INTEGER DEFAULT NULL,
    -- Here are columns for the actual tests
    task TEXT NOT NULL,
    square INTEGER NOT NULL,
    expected INTEGER NOT NULL
);

-- Note: the strings below may contain literal tab, newline, carriage returns.

INSERT INTO tests (uuid, name, task, square, expected)
    VALUES
        ("9fbde8de-36b2-49de-baf2-cd42d6f28405", "grains on square 1", "single-square", 1, 1),
        ("ee1f30c2-01d8-4298-b25d-c677331b5e6d", "grains on square 2", "single-square", 2, 2),
        ("10f45584-2fc3-4875-8ec6-666065d1163b", "grains on square 3", "single-square", 3, 4),
        ("a7cbe01b-36f4-4601-b053-c5f6ae055170", "grains on square 4", "single-square", 4, 8),
        ("c50acc89-8535-44e4-918f-b848ad2817d4", "grains on square 16", "single-square", 16, 32768),
        ("acd81b46-c2ad-4951-b848-80d15ed5a04f", "grains on square 32", "single-square", 32, 2147483648),
        ("c73b470a-5efb-4d53-9ac6-c5f6487f227b", "grains on square 64", "single-square", 64, 9223372036854775808),
        ("6eb07385-3659-4b45-a6be-9dc474222750", "returns the total number of grains on the board", "total", "", 18446744073709551615);

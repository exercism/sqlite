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
    number INT NOT NULL,
    expected TEXT NOT NULL
);

-- Note: the strings below _may_ contain literal tab, newline, or carriage returns.

INSERT INTO tests (uuid, name, number, expected)
    VALUES
        ('559e789d-07d1-4422-9004-3b699f83bca3', '0 eggs', 0, 0),
        ('97223282-f71e-490c-92f0-b3ec9e275aba', '1 egg', 16, 1),
        ('1f8fd18f-26e9-4144-9a0e-57cdfc4f4ff5', '4 eggs', 89, 4),
        ('0c18be92-a498-4ef2-bcbb-28ac4b06cb81', '13 eggs', 2000000000, 13);

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

-- Note: the strings below contain literal tab, newline, carriage returns.

INSERT INTO tests (uuid, description, input, expected)
    VALUES
        ('1cf3e15a-a3d7-4a87-aeb3-ba1b43bc8dce', 'no name given', '', 'One for you, one for me.'),
        ('b4c6dbb8-b4fb-42c2-bafd-10785abe7709', 'a name given', 'Alice', 'One for Alice, one for me.'),
        ('3549048d-1a6e-4653-9a79-b0bda163e8d5', 'another name given', 'Bob', 'One for Bob, one for me.');

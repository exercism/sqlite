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
    number INT NOT NULL,
    expected TEXT NOT NULL
);

-- Note: the strings below contain literal tab, newline, carriage returns.

INSERT INTO tests (uuid, description, number, expected)
    VALUES
        ('540a3d51-e7a6-47a5-92a3-4ad1838f0bfd', 'zero steps for one' 1, 0),
        ('3d76a0a6-ea84-444a-821a-f7857c2c1859', 'divide if even', 16, 4),
        ('754dea81-123c-429e-b8bc-db20b05a87b9', 'even and odd steps', 12, 9),
        ('ecfd0210-6f85-44f6-8280-f65534892ff6', 'large number of even and odd steps', 1000000, 152);

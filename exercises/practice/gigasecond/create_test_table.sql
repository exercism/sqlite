
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
    moment TEXT NOT NULL,
    result TEXT NOT NULL
);

-- Note: the strings below contain literal tab, newline, carriage returns.
INSERT INTO tests (uuid, description, moment, result)
    VALUES
        ('92fbe71c-ea52-4fac-bd77-be38023cacf7', 'date only specification of time', '2011-04-25', '2043-01-01T01:46:40'),
        ('6d86dd16-6f7a-47be-9e58-bb9fb2ae1433', 'second test for date only specification of time', '1977-06-13', '2009-02-19T01:46:40'),
        ('77eb8502-2bca-4d92-89d9-7b39ace28dd5', 'third test for date only specification of time', '1959-07-19', '1991-03-27T01:46:40'),
        ('c9d89a7d-06f8-4e28-a305-64f1b2abc693', 'full time specified', '2015-01-24T22:00:00', '2046-10-02T23:46:40'),
        ('09d4e30e-728a-4b52-9005-be44a58d9eba', 'full time with day roll-over', '2015-01-24T23:59:59', '2046-10-03T01:46:39');

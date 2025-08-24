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
    property TEXT NOT NULL,
    string TEXT NOT NULL,
    "index" INTEGER NOT NULL,
    expected TEXT NOT NULL      -- json array of integers
);

INSERT INTO tests (uuid, description, property, string, "index", expected)
VALUES
        ('ca733dab-9d85-4065-9ef6-a880a951dafd', 'extract row from one number matrix', 'row', '1', 1, '[1]'),
        ('5c93ec93-80e1-4268-9fc2-63bc7d23385c', 'can extract row', 'row', '1 2\n3 4', 2, '[3,4]'),
        ('2f1aad89-ad0f-4bd2-9919-99a8bff0305a', 'extract row where numbers have different widths', 'row', '1 2\n10 20', 2, '[10,20]'),
        ('68f7f6ba-57e2-4e87-82d0-ad09889b5204', 'can extract row from non-square matrix with no corresponding column', 'row', '1 2 3\n4 5 6\n7 8 9\n8 7 6', 4, '[8,7,6]'),
        ('e8c74391-c93b-4aed-8bfe-f3c9beb89ebb', 'extract column from one number matrix', 'column', '1', 1, '[1]'),
        ('7136bdbd-b3dc-48c4-a10c-8230976d3727', 'can extract column', 'column', '1 2 3\n4 5 6\n7 8 9', 3, '[3,6,9]'),
        ('ad64f8d7-bba6-4182-8adf-0c14de3d0eca', 'can extract column from non-square matrix with no corresponding row', 'column', '1 2 3 4\n5 6 7 8\n9 8 7 6', 4, '[4,8,6]'),
        ('9eddfa5c-8474-440e-ae0a-f018c2a0dd89', 'extract column where numbers have different widths', 'column', '89 1903 3\n18 3 1\n9 4 800', 2, '[1903,3,4]');

UPDATE tests SET string = REPLACE(string, '\n', CHAR(10));

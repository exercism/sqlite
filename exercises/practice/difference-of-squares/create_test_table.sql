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
    property TEXT NOT NULL,
    expected TEXT NOT NULL
);

-- Note: the strings below _may_ contain literal tab, newline, or carriage returns.

INSERT INTO tests (uuid, name, number, property, expected)
    VALUES
        ('e46c542b-31fc-4506-bcae-6b62b3268537', 'square of sum 1', 1, 'squareOfSum', 1),
        ('9b3f96cb-638d-41ee-99b7-b4f9c0622948', 'square of sum 5', 5, 'squareOfSum', 225),
        ('54ba043f-3c35-4d43-86ff-3a41625d5e86', 'square of sum 100', 100, 'squareOfSum', 25502500),
        ('01d84507-b03e-4238-9395-dd61d03074b5', 'sum of squares 1', 1, 'sumOfSquares', 1),
        ('c93900cd-8cc2-4ca4-917b-dd3027023499', 'sum of squares 5', 5, 'sumOfSquares', 55),
        ('94807386-73e4-4d9e-8dec-69eb135b19e4', 'sum of squares 100', 100, 'sumOfSquares', 338350),
        ('44f72ae6-31a7-437f-858d-2c0837adabb6', 'difference of squares 1', 1, 'differenceOfSquares', 0),
        ('005cb2bf-a0c8-46f3-ae25-924029f8b00b', 'difference of squares 5', 5, 'differenceOfSquares', 170),
        ('b1bf19de-9a16-41c0-a62b-1f02ecc0b036', 'difference of squares 100', 100, 'differenceOfSquares', 25164150);

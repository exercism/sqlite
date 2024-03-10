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
    expected BOOLEAN NOT NULL
);

-- Note: the strings below _may_ contain literal tab, newline, or carriage returns.

INSERT INTO tests (uuid, name, number, expected)
    VALUES
        ('c1ed103c-258d-45b2-be73-d8c6d9580c7b', 'Zero is an Armstrong number', 0, true),
        ('579e8f03-9659-4b85-a1a2-d64350f6b17a', 'Single-digit numbers are Armstrong numbers', 5, true),
        ('2d6db9dc-5bf8-4976-a90b-b2c2b9feba60', 'There are no two-digit Armstrong numbers', 10, false),
        ('509c087f-e327-4113-a7d2-26a4e9d18283', 'Three-digit number that is an Armstrong number', 153, true),
        ('7154547d-c2ce-468d-b214-4cb953b870cf', 'Three-digit number that is not an Armstrong number', 100, false),
        ('6bac5b7b-42e9-4ecb-a8b0-4832229aa103', 'Four-digit number that is an Armstrong number', 9474, true),
        ('eed4b331-af80-45b5-a80b-19c9ea444b2e', 'Four-digit number that is not an Armstrong number', 9475, false),
        ('f971ced7-8d68-4758-aea1-d4194900b864', 'Seven-digit number that is an Armstrong number', 9926315, true),
        ('7ee45d52-5d35-4fbd-b6f1-5c8cd8a67f18', 'Seven-digit number that is not an Armstrong number', 9926314, false);

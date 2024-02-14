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
    x REAL NOT NULL,
    y REAL NOT NULL,
    expected INTEGER NOT NULL
);

-- Note: the strings below contain literal tab, newline, carriage returns.

INSERT INTO tests (uuid, description, x, y, expected)
    VALUES
        ('9033f731-0a3a-4d9c-b1c0-34a1c8362afb', 'Missed target', -9, 9, 0),
        ('4c9f6ff4-c489-45fd-be8a-1fcb08b4d0ba', 'On the outer circle', 0, 10, 1),
        ('14378687-ee58-4c9b-a323-b089d5274be8', 'On the middle circle', -5, 0, 5),
        ('849e2e63-85bd-4fed-bc3b-781ae962e2c9', 'On the inner circle', 0, -1, 10),
        ('1c5ffd9f-ea66-462f-9f06-a1303de5a226', 'Exactly on center', 0, 0, 10),
        ('b65abce3-a679-4550-8115-4b74bda06088', 'Near the center', -0.1, -0.1, 10),
        ('66c29c1d-44f5-40cf-9927-e09a1305b399', 'Just within the inner circle', 0.7, 0.7, 10),
        ('d1012f63-c97c-4394-b944-7beb3d0b141a', 'Just outside the inner circle', 0.8, -0.8, 5),
        ('ab2b5666-b0b4-49c3-9b27-205e790ed945', 'Just within the middle circle', -3.5, 3.5, 5),
        ('70f1424e-d690-4860-8caf-9740a52c0161', 'Just outside the middle circle', -3.6, -3.6, 1),
        ('a7dbf8db-419c-4712-8a7f-67602b69b293', 'Just within the outer circle', -7.0, 7.0, 1),
        ('e0f39315-9f9a-4546-96e4-a9475b885aa7', 'Just outside the outer circle', 7.1, -7.1, 0),
        ('045d7d18-d863-4229-818e-b50828c75d19', 'Asymmetric position between the inner and middle circles', 0.5, -4, 5);

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
    text TEXT NOT NULL,
    shift_key INTEGER NOT NULL,
    expected TEXT NOT NULL
);

INSERT INTO tests (uuid, description, text, shift_key, expected)
    VALUES
        ('74e58a38-e484-43f1-9466-877a7515e10f', 'rotate a by 0, same output as input', 'a', 0, 'a'),
        ('7ee352c6-e6b0-4930-b903-d09943ecb8f5', 'rotate a by 1', 'a', 1, 'b'),
        ('edf0a733-4231-4594-a5ee-46a4009ad764', 'rotate a by 26, same output as input', 'a', 26, 'a'),
        ('e3e82cb9-2a5b-403f-9931-e43213879300', 'rotate m by 13', 'm', 13, 'z'),
        ('19f9eb78-e2ad-4da4-8fe3-9291d47c1709', 'rotate n by 13 with wrap around alphabet', 'n', 13, 'a'),
        ('a116aef4-225b-4da9-884f-e8023ca6408a', 'rotate capital letters', 'OMG', 5, 'TRL'),
        ('71b541bb-819c-4dc6-a9c3-132ef9bb737b', 'rotate spaces', 'O M G', 5, 'T R L'),
        ('ef32601d-e9ef-4b29-b2b5-8971392282e6', 'rotate numbers', 'Testing 1 2 3 testing', 4, 'Xiwxmrk 1 2 3 xiwxmrk'),
        ('32dd74f6-db2b-41a6-b02c-82eb4f93e549', 'rotate punctuation', 'Let''s eat, Grandma!', 21, 'Gzo''n zvo, Bmviyhv!'),
        ('9fb93fe6-42b0-46e6-9ec1-0bf0a062d8c9', 'rotate all letters', 'The quick brown fox jumps over the lazy dog.', 13, 'Gur dhvpx oebja sbk whzcf bire gur ynml qbt.');

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
    function TEXT NOT NULL,
    input INT NOT NULL,
    expected TEXT NOT NULL
);

-- Note: the strings below _may_ literal tab, newline, carriage returns.

INSERT INTO tests (uuid, description, function, input, expected)
    VALUES
        ('1035eb93-2208-4c22-bab8-fef06769a73c','List of scores','scores','30,50,20,70','30,50,20,70'),
        ('6aa5dbf5-78fa-4375-b22c-ffaa989732d2','Latest score','latest','100,0,90,30',30),
        ('b661a2e1-aebf-4f50-9139-0fb817dd12c6','Personal best','personalBest','40,100,70',100),
        ('3d996a97-c81c-4642-9afc-80b80dc14015','Personal top three from a list of scores','personalTopThree','10,30,90,30,100,20,10,0,30,40,40,70,70','100,90,70'),
        ('1084ecb5-3eb4-46fe-a816-e40331a4e83a','Personal top highest to lowest','personalTopThree','20,10,30','30,20,10'),
        ('e6465b6b-5a11-4936-bfe3-35241c4f4f16','Personal top when there is a tie','personalTopThree','40,20,40,30','40,40,30'),
        ('f73b02af-c8fd-41c9-91b9-c86eaa86bce2','Personal top when there are less than 3','personalTopThree','30,70','70,30'),
        ('16608eae-f60f-4a88-800e-aabce5df2865','Personal top when there is only one','personalTopThree','40','40'),
        ('2df075f9-fec9-4756-8f40-98c52a11504f','Latest score after personal top scores','latest','70,50,20,30','30'),
        ('809c4058-7eb1-4206-b01e-79238b9b71bc','Scores after personal top scores','scores','30,50,20,70','30,50,20,70'),
        ('ddb0efc0-9a86-4f82-bc30-21ae0bdc6418','Latest score after personal best','latest','20,70,15,25,30','30'),
        ('6a0fd2d1-4cc4-46b9-a5bb-2fb667ca2364','Scores after personal best','scores','20,70,15,25,30','20,70,15,25,30');

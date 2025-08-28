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
    expected TEXT NOT NULL
);

INSERT INTO tests (uuid, description, property, string, expected)
VALUES
        ('ad53b61b-6ffc-422f-81a6-61f7df92a231', 'empty string', 'encode', '', ''),
        ('52012823-b7e6-4277-893c-5b96d42f82de', 'single characters only are encoded without count', 'encode', 'XYZ', 'XYZ'),
        ('b7868492-7e3a-415f-8da3-d88f51f80409', 'string with no single characters', 'encode', 'AABBBCCCC', '2A3B4C'),
        ('859b822b-6e9f-44d6-9c46-6091ee6ae358', 'single characters mixed with repeated characters', 'encode', 'WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWB', '12WB12W3B24WB'),
        ('1b34de62-e152-47be-bc88-469746df63b3', 'multiple whitespace mixed in string', 'encode', '  hsqq qww  ', '2 hs2q q2w2 '),
        ('abf176e2-3fbd-40ad-bb2f-2dd6d4df721a', 'lowercase characters', 'encode', 'aabbbcccc', '2a3b4c'),
        ('7ec5c390-f03c-4acf-ac29-5f65861cdeb5', 'empty string', 'decode', '', ''),
        ('ad23f455-1ac2-4b0e-87d0-b85b10696098', 'single characters only', 'decode', 'XYZ', 'XYZ'),
        ('21e37583-5a20-4a0e-826c-3dee2c375f54', 'string with no single characters', 'decode', '2A3B4C', 'AABBBCCCC'),
        ('1389ad09-c3a8-4813-9324-99363fba429c', 'single characters with repeated characters', 'decode', '12WB12W3B24WB', 'WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWB'),
        ('3f8e3c51-6aca-4670-b86c-a213bf4706b0', 'multiple whitespace mixed in string', 'decode', '2 hs2q q2w2 ', '  hsqq qww  '),
        ('29f721de-9aad-435f-ba37-7662df4fb551', 'lowercase string', 'decode', '2a3b4c', 'aabbbcccc'),
        ('2a762efd-8695-4e04-b0d6-9736899fbc16', 'encode followed by decode gives original string', 'consistency', 'zzz ZZ  zZ', 'zzz ZZ  zZ');


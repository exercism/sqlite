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
    value TEXT NOT NULL,
    expected Boolean NOT NULL
);

-- Note: the strings below _may_ contain literal tab, newline, or carriage returns.

INSERT INTO tests (uuid, name, value, expected)
    VALUES
    ("792a7082-feb7-48c7-b88b-bbfec160865e", "single digit strings can not be valid", "1", false),
    ("698a7924-64d4-4d89-8daa-32e1aadc271e", "a single zero is invalid", "0", false),
    ("73c2f62b-9b10-4c9f-9a04-83cee7367965", "a simple valid SIN that remains valid if reversed", "059",  true),
    ("9369092e-b095-439f-948d-498bd076be11", "a simple valid SIN that becomes invalid if reversed", "59",  true),
    ("8f9f2350-1faf-4008-ba84-85cbb93ffeca", "a valid Canadian SIN", "055 444 285",  true),
    ("1cdcf269-6560-44fc-91f6-5819a7548737", "invalid Canadian SIN", "055 444 286", false),
    ("656c48c1-34e8-4e60-9a5a-aad8a367810a", "invalid credit card", "8273 1232 7352 0569", false),
    ("20e67fad-2121-43ed-99a8-14b5b856adb9", "invalid long number with an even remainder", "1 2345 6789 1234 5678 9012", false),
    ("7e7c9fc1-d994-457c-811e-d390d52fba5e", "invalid long number with a remainder divisible by 5", "1 2345 6789 1234 5678 9013", false),
    ("ad2a0c5f-84ed-4e5b-95da-6011d6f4f0aa", "valid number with an even number of digits", "095 245 88",  true),
    ("ef081c06-a41f-4761-8492-385e13c8202d", "valid number with an odd number of spaces", "234 567 891 234",  true),
    ("bef66f64-6100-4cbb-8f94-4c9713c5e5b2", "valid strings with a non-digit added at the end become invalid", "059a", false),
    ("2177e225-9ce7-40f6-b55d-fa420e62938e", "valid strings with punctuation included become invalid", "055-444-285", false),
    ("ebf04f27-9698-45e1-9afe-7e0851d0fe8d", "valid strings with symbols included become invalid", "055# 444$ 285", false),
    ("08195c5e-ce7f-422c-a5eb-3e45fece68ba", "single zero with space is invalid", " 0", false),
    ("12e63a3c-f866-4a79-8c14-b359fc386091", "more than a single zero is valid", "0000 0",  true),
    ("ab56fa80-5de8-4735-8a4a-14dae588663e", "input digit 9 is correctly converted to output digit 9", "091",  true),
    ("b9887ee8-8337-46c5-bc45-3bcab51bc36f", "very long input is valid", "9999999999 9999999999 9999999999 9999999999",  true),
    ("8a7c0e24-85ea-4154-9cf1-c2db90eabc08", "valid luhn with an odd number of digits and non zero first digit", "109",  true),
    ("39a06a5a-5bad-4e0f-b215-b042d46209b1", "using ascii value for non-doubled non-digit isn't allowed", "055b 444 285", false),
    ("f94cf191-a62f-4868-bc72-7253114aa157", "using ascii value for doubled non-digit isn't allowed", ":9", false),
    ("8b72ad26-c8be-49a2-b99c-bcc3bf631b33", "non-numeric, non-space char in the middle with a sum that's divisible by 10 isn't allowed", "59%59", false);

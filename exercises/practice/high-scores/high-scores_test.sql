-- Setup test table and read in student solution:
.read ./test_setup.sql

-- Test cases:
-- Note: the strings below may contain literal tab, newline, carriage returns.

INSERT INTO tests (description, uuid,
                    function, input, expected)
    VALUES
        ('List of scores', '1035eb93-2208-4c22-bab8-fef06769a73c',
            'scores', '30,50,20,70', '30,50,20,70'),
        ('Latest score', '6aa5dbf5-78fa-4375-b22c-ffaa989732d2',
            'latest', '100,0,90,30',30),
        ('Personal best', 'b661a2e1-aebf-4f50-9139-0fb817dd12c6',
            'personalBest', '40,100,70',100),
        ('Personal top three from a list of scores', '3d996a97-c81c-4642-9afc-80b80dc14015',
            'personalTopThree', '10,30,90,30,100,20,10,0,30,40,40,70,70', '100,90,70'),
        ('Personal top highest to lowest', '1084ecb5-3eb4-46fe-a816-e40331a4e83a',
            'personalTopThree', '20,10,30', '30,20,10'),
        ('Personal top when there is a tie', 'e6465b6b-5a11-4936-bfe3-35241c4f4f16',
            'personalTopThree', '40,20,40,30', '40,40,30'),
        ('Personal top when there are less than 3', 'f73b02af-c8fd-41c9-91b9-c86eaa86bce2',
            'personalTopThree', '30,70', '70,30'),
        ('Personal top when there is only one', '16608eae-f60f-4a88-800e-aabce5df2865',
            'personalTopThree', '40', '40'),
        ('Latest score after personal top scores', '2df075f9-fec9-4756-8f40-98c52a11504f',
            'latest', '70,50,20,30', '30'),
        ('Scores after personal top scores', '809c4058-7eb1-4206-b01e-79238b9b71bc',
            'scores', '30,50,20,70', '30,50,20,70'),
        ('Latest score after personal best', 'ddb0efc0-9a86-4f82-bc30-21ae0bdc6418',
            'latest', '20,70,15,25,30', '30'),
        ('Scores after personal best', '6a0fd2d1-4cc4-46b9-a5bb-2fb667ca2364',
            'scores', '20,70,15,25,30', '20,70,15,25,30');

-- Comparison of user input and the tests updates the status for each test:
UPDATE tests
SET status = 'pass'
FROM (SELECT game_id, result FROM results) AS actual
WHERE (actual.game_id, actual.result) = (tests.uuid, tests.expected);

-- Write results and debug info:
.read ./test_reporter.sql

-- Setup test table and read in student solution:
.read ./test_setup.sql

-- Test cases:
INSERT INTO tests (name, uuid,
                    dice_results, category, expected)
    VALUES
        ('Yacht', '3060e4a5-4063-4deb-a380-a630b43a84b6',
            '5, 5, 5, 5, 5', 'yacht', 50),
        ('Not Yacht', '15026df2-f567-482f-b4d5-5297d57769d9',
            '1, 3, 3, 2, 5', 'yacht', 0),
        ('Ones', '36b6af0c-ca06-4666-97de-5d31213957a4',
            '1, 1, 1, 3, 5', 'ones', 3),
        ('Ones, out of order', '023a07c8-6c6e-44d0-bc17-efc5e1b8205a',
            '3, 1, 1, 5, 1', 'ones', 3),
        ('No ones', '7189afac-cccd-4a74-8182-1cb1f374e496',
            '4, 3, 6, 5, 5', 'ones', 0),
        ('Twos', '793c4292-dd14-49c4-9707-6d9c56cee725',
            '2, 3, 4, 5, 6', 'twos', 2),
        ('Fours', 'dc41bceb-d0c5-4634-a734-c01b4233a0c6',
            '1, 4, 1, 4, 1', 'fours', 8),
        ('Yacht counted as threes', 'f6125417-5c8a-4bca-bc5b-b4b76d0d28c8',
            '3, 3, 3, 3, 3', 'threes', 15),
        ('Yacht of 3s counted as fives', '464fc809-96ed-46e4-acb8-d44e302e9726',
            '3, 3, 3, 3, 3', 'fives', 0),
        ('Fives', 'd054227f-3a71-4565-a684-5c7e621ec1e9',
            '1, 5, 3, 5, 3', 'fives', 10),
        ('Sixes', 'e8a036e0-9d21-443a-8b5f-e15a9e19a761',
            '2, 3, 4, 5, 6', 'sixes', 6),
        ('Full house two small, three big', '51cb26db-6b24-49af-a9ff-12f53b252eea',
            '2, 2, 4, 4, 4', 'full house', 16),
        ('Full house three small, two big', '1822ca9d-f235-4447-b430-2e8cfc448f0c',
            '5, 3, 3, 5, 3', 'full house', 19),
        ('Two pair is not a full house', 'b208a3fc-db2e-4363-a936-9e9a71e69c07',
            '2, 2, 4, 4, 5', 'full house', 0),
        ('Four of a kind is not a full house', 'b90209c3-5956-445b-8a0b-0ac8b906b1c2',
            '1, 4, 4, 4, 4', 'full house', 0),
        ('Yacht is not a full house', '32a3f4ee-9142-4edf-ba70-6c0f96eb4b0c',
            '2, 2, 2, 2, 2', 'full house', 0),
        ('Four of a Kind', 'b286084d-0568-4460-844a-ba79d71d79c6',
            '6, 6, 4, 6, 6', 'four of a kind', 24),
        ('Yacht can be scored as Four of a Kind', 'f25c0c90-5397-4732-9779-b1e9b5f612ca',
            '3, 3, 3, 3, 3', 'four of a kind', 12),
        ('Full house is not Four of a Kind', '9f8ef4f0-72bb-401a-a871-cbad39c9cb08',
            '3, 3, 3, 5, 5', 'four of a kind', 0),
        ('Little Straight', 'b4743c82-1eb8-4a65-98f7-33ad126905cd',
            '3, 5, 4, 1, 2', 'little straight', 30),
        ('Little Straight as Big Straight', '7ac08422-41bf-459c-8187-a38a12d080bc',
            '1, 2, 3, 4, 5', 'big straight', 0),
        ('Four in order but not a little straight', '97bde8f7-9058-43ea-9de7-0bc3ed6d3002',
            '1, 1, 2, 3, 4', 'little straight', 0),
        ('No pairs but not a little straight', 'cef35ff9-9c5e-4fd2-ae95-6e4af5e95a99',
            '1, 2, 3, 4, 6', 'little straight', 0),
        ('Minimum is 1, maximum is 5, but not a little straight', 'fd785ad2-c060-4e45-81c6-ea2bbb781b9d',
            '1, 1, 3, 4, 5', 'little straight', 0),
        ('Big Straight', '35bd74a6-5cf6-431a-97a3-4f713663f467',
            '4, 6, 2, 5, 3', 'big straight', 30),
        ('Big Straight as little straight', '87c67e1e-3e87-4f3a-a9b1-62927822b250',
            '6, 5, 4, 3, 2', 'little straight', 0),
        ('No pairs but not a big straight', 'c1fa0a3a-40ba-4153-a42d-32bc34d2521e',
            '6, 5, 4, 3, 1', 'big straight', 0),
        ('Choice', '207e7300-5d10-43e5-afdd-213e3ac8827d',
            '3, 3, 5, 6, 6', 'choice', 23),
        ('Yacht as choice', 'b524c0cf-32d2-4b40-8fb3-be3500f3f135',
            '2, 2, 2, 2, 2', 'choice', 10);

-- Comparison of user input and the tests updates the status for each test:
UPDATE tests
SET status = 'pass'
FROM (SELECT dice_results, category, result FROM yacht) AS actual
WHERE (actual.dice_results, actual.category, actual.result) = (tests.dice_results, tests.category, tests.expected);

-- Write results and debug info:
.read ./test_reporter.sql

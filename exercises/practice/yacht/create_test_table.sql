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
    dice_results TEXT NOT NULL,
    category TEXT NOT NULL,
    expected INT NOT NULL
);

-- Note: the strings below may contain literal tab, newline, carriage returns.

INSERT INTO tests (uuid, name, dice_results, category, expected)
    VALUES
        ('3060e4a5-4063-4deb-a380-a630b43a84b6', 'Yacht', '5, 5, 5, 5, 5', 'yacht', 50),
        ('15026df2-f567-482f-b4d5-5297d57769d9', 'Not Yacht', '1, 3, 3, 2, 5', 'yacht', 0),
        ('36b6af0c-ca06-4666-97de-5d31213957a4', 'Ones', '1, 1, 1, 3, 5', 'ones', 3),
        ('023a07c8-6c6e-44d0-bc17-efc5e1b8205a', 'Ones, out of order', '3, 1, 1, 5, 1', 'ones', 3),
        ('7189afac-cccd-4a74-8182-1cb1f374e496', 'No ones', '4, 3, 6, 5, 5', 'ones', 0),
        ('793c4292-dd14-49c4-9707-6d9c56cee725', 'Twos', '2, 3, 4, 5, 6', 'twos', 2),
        ('dc41bceb-d0c5-4634-a734-c01b4233a0c6', 'Fours', '1, 4, 1, 4, 1', 'fours', 8),
        ('f6125417-5c8a-4bca-bc5b-b4b76d0d28c8', 'Yacht counted as threes', '3, 3, 3, 3, 3', 'threes', 15),
        ('464fc809-96ed-46e4-acb8-d44e302e9726', 'Yacht of 3s counted as fives', '3, 3, 3, 3, 3', 'fives', 0),
        ('d054227f-3a71-4565-a684-5c7e621ec1e9', 'Fives', '1, 5, 3, 5, 3', 'fives', 10),
        ('e8a036e0-9d21-443a-8b5f-e15a9e19a761', 'Sixes', '2, 3, 4, 5, 6', 'sixes', 6),
        ('51cb26db-6b24-49af-a9ff-12f53b252eea', 'Full house two small, three big', '2, 2, 4, 4, 4', 'full house', 16),
        ('1822ca9d-f235-4447-b430-2e8cfc448f0c', 'Full house three small, two big', '5, 3, 3, 5, 3', 'full house', 19),
        ('b208a3fc-db2e-4363-a936-9e9a71e69c07', 'Two pair is not a full house', '2, 2, 4, 4, 5', 'full house', 0),
        ('b90209c3-5956-445b-8a0b-0ac8b906b1c2', 'Four of a kind is not a full house', '1, 4, 4, 4, 4', 'full house', 0),
        ('32a3f4ee-9142-4edf-ba70-6c0f96eb4b0c', 'Yacht is not a full house', '2, 2, 2, 2, 2', 'full house', 0),
        ('b286084d-0568-4460-844a-ba79d71d79c6', 'Four of a Kind', '6, 6, 4, 6, 6', 'four of a kind', 24),
        ('f25c0c90-5397-4732-9779-b1e9b5f612ca', 'Yacht can be scored as Four of a Kind', '3, 3, 3, 3, 3', 'four of a kind', 12),
        ('9f8ef4f0-72bb-401a-a871-cbad39c9cb08', 'Full house is not Four of a Kind', '3, 3, 3, 5, 5', 'four of a kind', 0),
        ('b4743c82-1eb8-4a65-98f7-33ad126905cd', 'Little Straight', '3, 5, 4, 1, 2', 'little straight', 30),
        ('7ac08422-41bf-459c-8187-a38a12d080bc', 'Little Straight as Big Straight', '1, 2, 3, 4, 5', 'big straight', 0),
        ('97bde8f7-9058-43ea-9de7-0bc3ed6d3002', 'Four in order but not a little straight', '1, 1, 2, 3, 4', 'little straight', 0),
        ('cef35ff9-9c5e-4fd2-ae95-6e4af5e95a99', 'No pairs but not a little straight', '1, 2, 3, 4, 6', 'little straight', 0),
        ('fd785ad2-c060-4e45-81c6-ea2bbb781b9d', 'Minimum is 1, maximum is 5, but not a little straight', '1, 1, 3, 4, 5', 'little straight', 0),
        ('35bd74a6-5cf6-431a-97a3-4f713663f467', 'Big Straight', '4, 6, 2, 5, 3', 'big straight', 30),
        ('87c67e1e-3e87-4f3a-a9b1-62927822b250', 'Big Straight as little straight', '6, 5, 4, 3, 2', 'little straight', 0),
        ('c1fa0a3a-40ba-4153-a42d-32bc34d2521e', 'No pairs but not a big straight', '6, 5, 4, 3, 1', 'big straight', 0),
        ('207e7300-5d10-43e5-afdd-213e3ac8827d', 'Choice', '3, 3, 5, 6, 6', 'choice', 23),
        ('b524c0cf-32d2-4b40-8fb3-be3500f3f135', 'Yacht as choice', '2, 2, 2, 2, 2', 'choice', 10);

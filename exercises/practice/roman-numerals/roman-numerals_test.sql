-- Setup test table and read in student solution:
.read ./test_setup.sql

-- Test cases:
INSERT INTO tests (name, uuid,
                    number, expected)
    VALUES
        ('1 is I', '19828a3a-fbf7-4661-8ddd-cbaeee0e2178', 1, 'I'),
        ('2 is II', 'f088f064-2d35-4476-9a41-f576da3f7b03', 2, 'II'),
        ('3 is III', 'b374a79c-3bea-43e6-8db8-1286f79c7106', 3, 'III'),
        ('4 is IV', '05a0a1d4-a140-4db1-82e8-fcc21fdb49bb', 4, 'IV'),
        ('5 is V', '57c0f9ad-5024-46ab-975d-de18c430b290', 5, 'V'),
        ('6 is VI', '20a2b47f-e57f-4797-a541-0b3825d7f249', 6, 'VI'),
        ('9 is IX', 'ff3fb08c-4917-4aab-9f4e-d663491d083d', 9, 'IX'),
        ('16 is XVI', '6d1d82d5-bf3e-48af-9139-87d7165ed509', 16, 'XVI'),
        ('27 is XXVII', '2bda64ca-7d28-4c56-b08d-16ce65716cf6', 27, 'XXVII'),
        ('48 is XLVIII', 'a1f812ef-84da-4e02-b4f0-89c907d0962c', 48, 'XLVIII'),
        ('49 is XLIX', '607ead62-23d6-4c11-a396-ef821e2e5f75', 49, 'XLIX'),
        ('59 is LIX', 'd5b283d4-455d-4e68-aacf-add6c4b51915', 59, 'LIX'),
        ('66 is LXVI', '4465ffd5-34dc-44f3-ada5-56f5007b6dad', 66, 'LXVI'),
        ('93 is XCIII', '46b46e5b-24da-4180-bfe2-2ef30b39d0d0', 93, 'XCIII'),
        ('141 is CXLI', '30494be1-9afb-4f84-9d71-db9df18b55e3', 141, 'CXLI'),
        ('163 is CLXIII', '267f0207-3c55-459a-b81d-67cec7a46ed9', 163, 'CLXIII'),
        ('166 is CLXVI', '902ad132-0b4d-40e3-8597-ba5ed611dd8d', 166, 'CLXVI'),
        ('402 is CDII', 'cdb06885-4485-4d71-8bfb-c9d0f496b404', 402, 'CDII'),
        ('575 is DLXXV', '6b71841d-13b2-46b4-ba97-dec28133ea80', 575, 'DLXXV'),
        ('666 is DCLXVI', 'dacb84b9-ea1c-4a61-acbb-ce6b36674906', 666, 'DCLXVI'),
        ('911 is CMXI', '432de891-7fd6-4748-a7f6-156082eeca2f', 911, 'CMXI'),
        ('1024 is MXXIV', 'e6de6d24-f668-41c0-88d7-889c0254d173', 1024, 'MXXIV'),
        ('1666 is MDCLXVI', 'efbe1d6a-9f98-4eb5-82bc-72753e3ac328', 1666, 'MDCLXVI'),
        ('3000 is MMM', 'bb550038-d4eb-4be2-a9ce-f21961ac3bc6', 3000, 'MMM'),
        ('3001 is MMMI', '3bc4b41c-c2e6-49d9-9142-420691504336', 3001, 'MMMI'),
        ('3888 is MMMDCCCLXXXVIII', '2f89cad7-73f6-4d1b-857b-0ef531f68b7e', 3888, 'MMMDCCCLXXXVIII'),
        ('3999 is MMMCMXCIX', '4e18e96b-5fbb-43df-a91b-9cb511fe0856', 3999, 'MMMCMXCIX');

-- Comparison of user input and the tests updates the status for each test:
UPDATE tests
SET status = 'pass'
FROM (SELECT number, result FROM "roman-numerals") AS actual
WHERE (actual.number, actual.result) = (tests.number, tests.expected);

-- Write results and debug info:
.read ./test_reporter.sql


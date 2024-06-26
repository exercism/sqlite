-- Setup test table and read in student solution:
.read ./test_setup.sql

-- Test cases:
INSERT INTO tests (name, uuid, input, expected)
    VALUES
        ('paired square brackets', '81ec11da-38dd-442a-bcf9-3de7754609a5', '[]', 1),
        ('empty string', '287f0167-ac60-4b64-8452-a0aa8f4e5238', '', 1),
        ('unpaired brackets', '6c3615a3-df01-4130-a731-8ef5f5d78dac', '[[', 0),
        ('wrong ordered brackets', '9d414171-9b98-4cac-a4e5-941039a97a77', '}{', 0),
        ('wrong closing bracket', 'f0f97c94-a149-4736-bc61-f2c5148ffb85', '{]', 0),
        ('paired with whitespace', '754468e0-4696-4582-a30e-534d47d69756', '{ }', 1),
        ('partially paired brackets', 'ba84f6ee-8164-434a-9c3e-b02c7f8e8545', '{[])', 0),
        ('simple nested brackets', '3c86c897-5ff3-4a2b-ad9b-47ac3a30651d', '{[]}', 1),
        ('several paired brackets', '2d137f2c-a19e-4993-9830-83967a2d4726', '{}[]', 1),
        ('paired and nested brackets', '2e1f7b56-c137-4c92-9781-958638885a44', '([{}({}[])])', 1),
        ('unopened closing brackets', '84f6233b-e0f7-4077-8966-8085d295c19b', '{[)][]}', 0),
        ('unpaired and nested brackets', '9b18c67d-7595-4982-b2c5-4cb949745d49', '([{])', 0),
        ('paired and wrong nested brackets', 'a0205e34-c2ac-49e6-a88a-899508d7d68e', '[({]})', 0),
        ('paired and wrong nested brackets but innermost are correct', '1d5c093f-fc84-41fb-8c2a-e052f9581602', '[({}])', 0),
        ('paired and incomplete brackets', 'ef47c21b-bcfd-4998-844c-7ad5daad90a8', '{}[', 0),
        ('too many closing brackets', 'a4675a40-a8be-4fc2-bc47-2a282ce6edbe', '[]]', 0),
        ('early unexpected brackets', 'a345a753-d889-4b7e-99ae-34ac85910d1a', ')()', 0),
        ('early mismatched brackets', '21f81d61-1608-465a-b850-baa44c5def83', '{)()', 0),
        ('math expression', '99255f93-261b-4435-a352-02bdecc9bdf2', '(((185 + 223.85) * 15) - 543)/2', 1),
        ('complex latex expression', '8e357d79-f302-469a-8515-2561877256a1', '\left(\begin{array}{cc} \frac{1}{3} & x\\ \mathrm{e}^{x} &... x^2 \end{array}\right)', 1);

-- Comparison of user input and the tests updates the status for each test:
UPDATE tests
SET status = 'pass'
FROM (SELECT input, result FROM "matching-brackets") AS actual
WHERE (actual.input, actual.result) = (tests.input, tests.expected);

-- Write results and debug info:
.read ./test_reporter.sql

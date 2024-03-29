-- Setup test table and read in student solution:
.read ./test_setup.sql

-- Test cases:
INSERT INTO tests (name, uuid,
                    number, result)
    VALUES
        ('the sound for 1 is 1', '1575d549-e502-46d4-a8e1-6b7bec6123d8',
            1, '1'),
        ('the sound for 3 is Pling', '1f51a9f9-4895-4539-b182-d7b0a5ab2913',
            3, 'Pling'),
        ('the sound for 5 is Plang', '2d9bfae5-2b21-4bcd-9629-c8c0e388f3e0',
            5, 'Plang'),
        ('the sound for 7 is Plong', 'd7e60daa-32ef-4c23-b688-2abff46c4806',
            7, 'Plong'),
        ('the sound for 6 is Pling as it has a factor 3', '6bb4947b-a724-430c-923f-f0dc3d62e56a',
            6, 'Pling'),
        ('2 to the power 3 does not make a raindrop sound as 3 is the exponent not the base', 'ce51e0e8-d9d4-446d-9949-96eac4458c2d',
            8, '8'),
        ('the sound for 9 is Pling as it has a factor 3', '0dd66175-e3e2-47fc-8750-d01739856671',
            9, 'Pling'),
        ('the sound for 10 is Plang as it has a factor 5', '022c44d3-2182-4471-95d7-c575af225c96',
            10, 'Plang'),
        ('the sound for 14 is Plong as it has a factor of 7', '37ab74db-fed3-40ff-b7b9-04acdfea8edf',
            14, 'Plong'),
        ('the sound for 15 is PlingPlang as it has factors 3 and 5', '31f92999-6afb-40ee-9aa4-6d15e3334d0f',
            15, 'PlingPlang'),
        ('the sound for 21 is PlingPlong as it has factors 3 and 7', 'ff9bb95d-6361-4602-be2c-653fe5239b54',
            21, 'PlingPlong'),
        ('the sound for 25 is Plang as it has a factor 5', 'd2e75317-b72e-40ab-8a64-6734a21dece1',
            25, 'Plang'),
        ('the sound for 27 is Pling as it has a factor 3', 'a09c4c58-c662-4e32-97fe-f1501ef7125c',
            27, 'Pling'),
        ('the sound for 35 is PlangPlong as it has factors 5 and 7', 'bdf061de-8564-4899-a843-14b48b722789',
            35, 'PlangPlong'),
        ('the sound for 49 is Plong as it has a factor 7', 'c4680bee-69ba-439d-99b5-70c5fd1a7a83',
            49, 'Plong'),
        ('the sound for 52 is 52', '17f2bc9a-b65a-4d23-8ccd-266e8c271444',
            52, '52'),
        ('the sound for 105 is PlingPlangPlong as it has factors 3, 5 and 7', 'e46677ed-ff1a-419f-a740-5c713d2830e4',
            105, 'PlingPlangPlong'),
        ('the sound for 3125 is Plang as it has a factor 5', '13c6837a-0fcd-4b86-a0eb-20572f7deb0b',
            3125, 'Plang');

-- Comparison of user input and the tests updates the status for each test:
UPDATE tests
SET status = 'pass'
FROM (SELECT number, sound FROM raindrops) AS actual
WHERE (actual.number, actual.sound) = (tests.number, tests.result);

-- Write results and debug info:
.read ./test_reporter.sql

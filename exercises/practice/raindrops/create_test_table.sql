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
    number INT NOT NULL,
    result TEXT NOT NULL
);

INSERT INTO tests (uuid, description, number, result)
    VALUES
        -- Every test case from the .meta/tests.toml file gets its own row:
        ('1575d549-e502-46d4-a8e1-6b7bec6123d8', 'the sound for 1 is 1', 1, '1'),
        ('1f51a9f9-4895-4539-b182-d7b0a5ab2913', 'the sound for 3 is Pling', 3, 'Pling'),
        ('2d9bfae5-2b21-4bcd-9629-c8c0e388f3e0', 'the sound for 5 is Plang', 5, 'Plang'),
        ('d7e60daa-32ef-4c23-b688-2abff46c4806', 'the sound for 7 is Plong', 7, 'Plong'),
        ('6bb4947b-a724-430c-923f-f0dc3d62e56a', 'the sound for 6 is Pling as it has a factor 3', 6, 'Pling'),
        ('ce51e0e8-d9d4-446d-9949-96eac4458c2d', '2 to the power 3 does not make a raindrop sound as 3 is the exponent not the base', 8, '8'),
        ('0dd66175-e3e2-47fc-8750-d01739856671', 'the sound for 9 is Pling as it has a factor 3', 9, 'Pling'),
        ('022c44d3-2182-4471-95d7-c575af225c96', 'the sound for 10 is Plang as it has a factor 5', 10, 'Plang'),
        ('37ab74db-fed3-40ff-b7b9-04acdfea8edf', 'the sound for 14 is Plong as it has a factor of 7', 14, 'Plong'),
        ('31f92999-6afb-40ee-9aa4-6d15e3334d0f', 'the sound for 15 is PlingPlang as it has factors 3 and 5', 15, 'PlingPlang'),
        ('ff9bb95d-6361-4602-be2c-653fe5239b54', 'the sound for 21 is PlingPlong as it has factors 3 and 7', 21, 'PlingPlong'),
        ('d2e75317-b72e-40ab-8a64-6734a21dece1', 'the sound for 25 is Plang as it has a factor 5', 25, 'Plang'),
        ('a09c4c58-c662-4e32-97fe-f1501ef7125c', 'the sound for 27 is Pling as it has a factor 3', 27, 'Pling'),
        ('bdf061de-8564-4899-a843-14b48b722789', 'the sound for 35 is PlangPlong as it has factors 5 and 7', 35, 'PlangPlong'),
        ('c4680bee-69ba-439d-99b5-70c5fd1a7a83', 'the sound for 49 is Plong as it has a factor 7', 49, 'Plong'),
        ('17f2bc9a-b65a-4d23-8ccd-266e8c271444', 'the sound for 52 is 52', 52, '52'),
        ('e46677ed-ff1a-419f-a740-5c713d2830e4', 'the sound for 105 is PlingPlangPlong as it has factors 3, 5 and 7', 105, 'PlingPlangPlong'),
        ('13c6837a-0fcd-4b86-a0eb-20572f7deb0b', 'the sound for 3125 is Plang as it has a factor 5', 3125, 'Plang');

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
    color1 TEXT NOT NULL,
    color2 TEXT NOT NULL,
    expected INTEGER NOT NULL
);

INSERT INTO tests (uuid, description, color1, color2, expected)
    VALUES
        -- Every test case from the .meta/tests.toml file gets its own row:
        ('ce11995a-5b93-4950-a5e9-93423693b2fc', 'Brown and black', 'brown', 'black', 10),
        ('7bf82f7a-af23-48ba-a97d-38d59406a920', 'Blue and grey', 'blue', 'grey', 68),
        ('f1886361-fdfd-4693-acf8-46726fe24e0c', 'Yellow and violet', 'yellow', 'violet', 47),
        ('b7a6cbd2-ae3c-470a-93eb-56670b305640', 'White and red', 'white', 'red', 92),
        ('77a8293d-2a83-4016-b1af-991acc12b9fe', 'Orange and orange', 'orange', 'orange', 33),
        ('4a8ceec5-0ab4-4904-88a4-daf953a5e818', 'Black and brown, one-digit', 'black', 'brown', 1);

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
    word     TEXT    NOT NULL,
    expected INTEGER NOT NULL
);

INSERT INTO tests (uuid, description, word, expected)
VALUES
        ('f46cda29-1ca5-4ef2-bd45-388a767e3db2','lowercase letter','a',1),
        ('f7794b49-f13e-45d1-a933-4e48459b2201','uppercase letter','A',1),
        ('eaba9c76-f9fa-49c9-a1b0-d1ba3a5b31fa','valuable letter','f',4),
        ('f3c8c94e-bb48-4da2-b09f-e832e103151e','short word','at',2),
        ('71e3d8fa-900d-4548-930e-68e7067c4615','short, valuable word','zoo',12),
        ('d3088ad9-570c-4b51-8764-c75d5a430e99','medium word','street',6),
        ('fa20c572-ad86-400a-8511-64512daac352','medium, valuable word','quirky',22),
        ('9336f0ba-9c2b-4fa0-bd1c-2e2d328cf967','long, mixed-case word','OxyphenButazone',41),
        ('1e34e2c3-e444-4ea7-b598-3c2b46fd2c10','english-like word','pinata',8),
        ('4efe3169-b3b6-4334-8bae-ff4ef24a7e4f','empty input','',0),
        ('3b305c1c-f260-4e15-a5b5-cb7d3ea7c3d7','entire alphabet available','abcdefghijklmnopqrstuvwxyz',87);

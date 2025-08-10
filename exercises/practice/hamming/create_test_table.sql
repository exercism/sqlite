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
    strand1  TEXT    NOT NULL,
    strand2  TEXT    NOT NULL,
    expected INTEGER NOT NULL
);

INSERT INTO tests (uuid, description, strand1, strand2, expected)
    VALUES
        ('f6dcb64f-03b0-4b60-81b1-3c9dbf47e887','empty strands','','',0),
        ('54681314-eee2-439a-9db0-b0636c656156','single letter identical strands','A','A',0),
        ('294479a3-a4c8-478f-8d63-6209815a827b','single letter different strands','G','T',1),
        ('9aed5f34-5693-4344-9b31-40c692fb5592','long identical strands','GGACTGAAATCTG','GGACTGAAATCTG',0),
        ('cd2273a5-c576-46c8-a52b-dee251c3e6e5','long different strands','GGACGGATTCTG','AGGACGGATTCT',9);

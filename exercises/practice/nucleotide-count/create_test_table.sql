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
    input INT NOT NULL,
    expected TEXT NOT NULL
);

INSERT INTO tests (uuid, name, input, expected)
    VALUES
        ('3e5c30a8-87e2-4845-a815-a49671ade970', 'empty strand', '', json(' { "A": 0, "C": 0, "G": 0, "T": 0 } ')),
        ('a0ea42a6-06d9-4ac6-828c-7ccaccf98fec', 'can count one nucleotide in single-character input', 'G', json(' { "A": 0, "C": 0, "G": 1, "T": 0 } ')),
        ('eca0d565-ed8c-43e7-9033-6cefbf5115b5', 'strand with repeated nucleotide', 'GGGGGGG', json(' { "A": 0, "C": 0, "G": 7, "T": 0 } ')),
        ('40a45eac-c83f-4740-901a-20b22d15a39f', 'strand with multiple nucleotides', 'AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC', json(' { "A": 20, "C": 12, "G": 17, "T": 21 } '));


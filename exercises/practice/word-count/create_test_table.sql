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
    sentence TEXT NOT NULL,
    expected TEXT NOT NULL      -- json object
);

INSERT INTO tests (uuid, description, sentence, expected)
    VALUES
        ('61559d5f-2cad-48fb-af53-d3973a9ee9ef','count one word','word','{"word":1}'),
        ('5abd53a3-1aed-43a4-a15a-29f88c09cbbd','count one of each word','one of each','{"one":1,"of":1,"each":1}'),
        ('2a3091e5-952e-4099-9fac-8f85d9655c0e','multiple occurrences of a word','one fish two fish red fish blue fish','{"one":1,"fish":4,"two":1,"red":1,"blue":1}'),
        ('e81877ae-d4da-4af4-931c-d923cd621ca6','handles cramped lists','one,two,three','{"one":1,"two":1,"three":1}'),
        ('7349f682-9707-47c0-a9af-be56e1e7ff30','handles expanded lists','one,\ntwo,\nthree','{"one":1,"two":1,"three":1}'),
        ('a514a0f2-8589-4279-8892-887f76a14c82','ignore punctuation','car: carpet as java: javascript!!&@$%^&','{"car":1,"carpet":1,"as":1,"java":1,"javascript":1}'),
        ('d2e5cee6-d2ec-497b-bdc9-3ebe092ce55e','include numbers','testing, 1, 2 testing','{"testing":2,"1":1,"2":1}'),
        ('dac6bc6a-21ae-4954-945d-d7f716392dbf','normalize case','go Go GO Stop stop','{"go":3,"stop":2}'),
        ('4ff6c7d7-fcfc-43ef-b8e7-34ff1837a2d3','with apostrophes','''First: don''t laugh. Then: don''t cry. You''re getting it.''','{"first":1,"don''t":2,"laugh":1,"then":1,"cry":1,"you''re":1,"getting":1,"it":1}'),
        ('be72af2b-8afe-4337-b151-b297202e4a7b','with quotations','Joe can''t tell between ''large'' and large.','{"joe":1,"can''t":1,"tell":1,"between":1,"large":2,"and":1}'),
        ('8d6815fe-8a51-4a65-96f9-2fb3f6dc6ed6','substrings from the beginning','Joe can''t tell between app, apple and a.','{"joe":1,"can''t":1,"tell":1,"between":1,"app":1,"apple":1,"and":1,"a":1}'),
        ('c5f4ef26-f3f7-4725-b314-855c04fb4c13','multiple spaces not detected as a word',' multiple   whitespaces','{"multiple":1,"whitespaces":1}'),
        ('50176e8a-fe8e-4f4c-b6b6-aa9cf8f20360','alternating word separators not detected as a word',',\n,one,\n ,two \n ''three''','{"one":1,"two":1,"three":1}'),
        ('6d00f1db-901c-4bec-9829-d20eb3044557','quotation for word with apostrophe','can, can''t, ''can''t''','{"can":1,"can''t":2}');

UPDATE tests SET sentence = REPLACE(sentence, '\n', CHAR(10));

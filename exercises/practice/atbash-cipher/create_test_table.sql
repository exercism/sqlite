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
    property TEXT NOT NULL,
    phrase   TEXT NOT NULL,
    expected TEXT NOT NULL
);

INSERT INTO tests (uuid, description, property, phrase, expected)
    VALUES
        ('2f47ebe1-eab9-4d6b-b3c6-627562a31c77','encode yes','encode','yes','bvh'),
        ('b4ffe781-ea81-4b74-b268-cc58ba21c739','encode no','encode','no','ml'),
        ('10e48927-24ab-4c4d-9d3f-3067724ace00','encode OMG','encode','OMG','lnt'),
        ('d59b8bc3-509a-4a9a-834c-6f501b98750b','encode spaces','encode','O M G','lnt'),
        ('31d44b11-81b7-4a94-8b43-4af6a2449429','encode mindblowingly','encode','mindblowingly','nrmwy oldrm tob'),
        ('d503361a-1433-48c0-aae0-d41b5baa33ff','encode numbers','encode','Testing,1 2 3, testing.','gvhgr mt123 gvhgr mt'),
        ('79c8a2d5-0772-42d4-b41b-531d0b5da926','encode deep thought','encode','Truth is fiction.','gifgs rhurx grlm'),
        ('9ca13d23-d32a-4967-a1fd-6100b8742bab','encode all the letters','encode','The quick brown fox jumps over the lazy dog.','gsvjf rxpyi ldmul cqfnk hlevi gsvoz abwlt'),
        ('bb50e087-7fdf-48e7-9223-284fe7e69851','decode exercism','decode','vcvix rhn','exercism'),
        ('ac021097-cd5d-4717-8907-b0814b9e292c','decode a sentence','decode','zmlyh gzxov rhlug vmzhg vkkrm thglm v','anobstacleisoftenasteppingstone'),
        ('18729de3-de74-49b8-b68c-025eaf77f851','decode numbers','decode','gvhgr mt123 gvhgr mt','testing123testing'),
        ('0f30325f-f53b-415d-ad3e-a7a4f63de034','decode all the letters','decode','gsvjf rxpyi ldmul cqfnk hlevi gsvoz abwlt','thequickbrownfoxjumpsoverthelazydog'),
        ('39640287-30c6-4c8c-9bac-9d613d1a5674','decode with too many spaces','decode','vc vix    r hn','exercism'),
        ('b34edf13-34c0-49b5-aa21-0768928000d5','decode with no spaces','decode','zmlyhgzxovrhlugvmzhgvkkrmthglmv','anobstacleisoftenasteppingstone');

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
    phrase TEXT NOT NULL,
    expected TEXT NOT NULL
);

INSERT INTO tests (uuid, description, phrase, expected)
VALUES
        ('11567f84-e8c6-4918-aedb-435f0b73db57', 'word beginning with a', 'apple', 'appleay'),
        ('f623f581-bc59-4f45-9032-90c3ca9d2d90', 'word beginning with e', 'ear', 'earay'),
        ('7dcb08b3-23a6-4e8a-b9aa-d4e859450d58', 'word beginning with i', 'igloo', 'iglooay'),
        ('0e5c3bff-266d-41c8-909f-364e4d16e09c', 'word beginning with o', 'object', 'objectay'),
        ('614ba363-ca3c-4e96-ab09-c7320799723c', 'word beginning with u', 'under', 'underay'),
        ('bf2538c6-69eb-4fa7-a494-5a3fec911326', 'word beginning with a vowel and followed by a qu', 'equal', 'equalay'),
        ('e5be8a01-2d8a-45eb-abb4-3fcc9582a303', 'word beginning with p', 'pig', 'igpay'),
        ('d36d1e13-a7ed-464d-a282-8820cb2261ce', 'word beginning with k', 'koala', 'oalakay'),
        ('d838b56f-0a89-4c90-b326-f16ff4e1dddc', 'word beginning with x', 'xenon', 'enonxay'),
        ('bce94a7a-a94e-4e2b-80f4-b2bb02e40f71', 'word beginning with q without a following u', 'qat', 'atqay'),
        ('e59dbbe8-ccee-4619-a8e9-ce017489bfc0', 'word beginning with consonant and vowel containing qu', 'liquid', 'iquidlay'),
        ('c01e049a-e3e2-451c-bf8e-e2abb7e438b8', 'word beginning with ch', 'chair', 'airchay'),
        ('9ba1669e-c43f-4b93-837a-cfc731fd1425', 'word beginning with qu', 'queen', 'eenquay'),
        ('92e82277-d5e4-43d7-8dd3-3a3b316c41f7', 'word beginning with qu and a preceding consonant', 'square', 'aresquay'),
        ('79ae4248-3499-4d5b-af46-5cb05fa073ac', 'word beginning with th', 'therapy', 'erapythay'),
        ('e0b3ae65-f508-4de3-8999-19c2f8e243e1', 'word beginning with thr', 'thrush', 'ushthray'),
        ('20bc19f9-5a35-4341-9d69-1627d6ee6b43', 'word beginning with sch', 'school', 'oolschay'),
        ('54b796cb-613d-4509-8c82-8fbf8fc0af9e', 'word beginning with yt', 'yttria', 'yttriaay'),
        ('8c37c5e1-872e-4630-ba6e-d20a959b67f6', 'word beginning with xr', 'xray', 'xrayay'),
        ('a4a36d33-96f3-422c-a233-d4021460ff00', 'y is treated like a consonant at the beginning of a word', 'yellow', 'ellowyay'),
        ('adc90017-1a12-4100-b595-e346105042c7', 'y is treated like a vowel at the end of a consonant cluster', 'rhythm', 'ythmrhay'),
        ('29b4ca3d-efe5-4a95-9a54-8467f2e5e59a', 'y as second letter in two letter word', 'my', 'ymay'),
        ('44616581-5ce3-4a81-82d0-40c7ab13d2cf', 'a whole phrase', 'quick fast run', 'ickquay astfay unray');

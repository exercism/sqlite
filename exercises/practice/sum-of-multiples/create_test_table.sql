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
    factors TEXT NOT NULL,      -- json array of integers
    "limit" INTEGER NOT NULL,
    expected INTEGER NOT NULL
);

INSERT INTO tests (uuid, description, factors, "limit", expected)
    VALUES
        ('54aaab5a-ce86-4edc-8b40-d3ab2400a279', 'no multiples within limit', '[3,5]', 1, 0),
        ('361e4e50-c89b-4f60-95ef-5bc5c595490a', 'one factor has multiples within limit', '[3,5]', 4, 3),
        ('e644e070-040e-4ae0-9910-93c69fc3f7ce', 'more than one multiple within limit', '[3]', 7, 9),
        ('607d6eb9-535c-41ce-91b5-3a61da3fa57f', 'more than one factor with multiples within limit', '[3,5]', 10, 23),
        ('f47e8209-c0c5-4786-b07b-dc273bf86b9b', 'each multiple is only counted once', '[3,5]', 100, 2318),
        ('28c4b267-c980-4054-93e9-07723db615ac', 'a much larger limit', '[3,5]', 1000, 233168),
        ('09c4494d-ff2d-4e0f-8421-f5532821ee12', 'three factors', '[7,13,17]', 20, 51),
        ('2d0d5faa-f177-4ad6-bde9-ebb865083751', 'factors not relatively prime', '[4,6]', 15, 30),
        ('ece8f2e8-96aa-4166-bbb7-6ce71261e354', 'some pairs of factors relatively prime and some not', '[5,6,8]', 150, 4419),
        ('624fdade-6ffb-400e-8472-456a38c171c0', 'one factor is a multiple of another', '[5,25]', 51, 275),
        ('949ee7eb-db51-479c-b5cb-4a22b40ac057', 'much larger factors', '[43,47]', 10000, 2203160),
        ('41093673-acbd-482c-ab80-d00a0cbedecd', 'all numbers are multiples of 1', '[1]', 100, 4950),
        ('1730453b-baaa-438e-a9c2-d754497b2a76', 'no factors means an empty sum', '[]', 10000, 0),
        ('214a01e9-f4bf-45bb-80f1-1dce9fbb0310', 'the only multiple of 0 is 0', '[0]', 1, 0),
        ('c423ae21-a0cb-4ec7-aeb1-32971af5b510', 'the factor 0 does not affect the sum of multiples of other factors', '[3,0]', 4, 3),
        ('17053ba9-112f-4ac0-aadb-0519dd836342', 'solutions using include-exclude must extend to cardinality greater than 3', '[2,3,5,7,11]', 10000, 39614537);

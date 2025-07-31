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
    color3 TEXT NOT NULL,
    expected TEXT NOT NULL
);

INSERT INTO tests (uuid, description, color1, color2, color3, expected)
    VALUES
        ('d6863355-15b7-40bb-abe0-bfb1a25512ed','Orange and orange and black','orange','orange','black','33 ohms'),
        ('1224a3a9-8c8e-4032-843a-5224e04647d6','Blue and grey and brown','blue','grey','brown','680 ohms'),
        ('b8bda7dc-6b95-4539-abb2-2ad51d66a207','Red and black and red','red','black','red','2 kiloohms'),
        ('5b1e74bc-d838-4eda-bbb3-eaba988e733b','Green and brown and orange','green','brown','orange','51 kiloohms'),
        ('f5d37ef9-1919-4719-a90d-a33c5a6934c9','Yellow and violet and yellow','yellow','violet','yellow','470 kiloohms'),
        ('5f6404a7-5bb3-4283-877d-3d39bcc33854','Blue and violet and blue','blue','violet','blue','67 megaohms'),
        ('7d3a6ab8-e40e-46c3-98b1-91639fff2344','Minimum possible value','black','black','black','0 ohms'),
        ('ca0aa0ac-3825-42de-9f07-dac68cc580fd','Maximum possible value','white','white','white','99 gigaohms'),
        ('0061a76c-903a-4714-8ce2-f26ce23b0e09','First two colors make an invalid octal number','black','grey','black','8 ohms');

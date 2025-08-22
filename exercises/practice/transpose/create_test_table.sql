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
    lines TEXT NOT NULL,
    expected TEXT NOT NULL
);

INSERT INTO tests (uuid, description, lines, expected)
VALUES
        ('404b7262-c050-4df0-a2a2-0cb06cd6a821', 'empty string', '', ''),
        ('a89ce8a3-c940-4703-a688-3ea39412fbcb', 'two characters in a row', 'A1', 'A\n1'),
        ('855bb6ae-4180-457c-abd0-ce489803ce98', 'two characters in a column', 'A\n1', 'A1'),
        ('5ceda1c0-f940-441c-a244-0ced197769c8', 'simple', 'ABC\n123', 'A1\nB2\nC3'),
        ('a54675dd-ae7d-4a58-a9c4-0c20e99a7c1f', 'single line', 'Single line.', 'S\ni\nn\ng\nl\ne\n \nl\ni\nn\ne\n.'),
        ('0dc2ec0b-549d-4047-aeeb-8029fec8d5c5', 'first line longer than second line', 'The fourth line.\nThe fifth line.', 'TT\nhh\nee\n  \nff\noi\nuf\nrt\nth\nh \n l\nli\nin\nne\ne.\n.'),
        ('984e2ec3-b3d3-4b53-8bd6-96f5ef404102', 'second line longer than first line', 'The first line.\nThe second line.', 'TT\nhh\nee\n  \nfs\nie\nrc\nso\ntn\n d\nl \nil\nni\nen\n.e\n .'),
        ('eccd3784-45f0-4a3f-865a-360cb323d314', 'mixed line length', 'The longest line.\nA long line.\nA longer line.\nA line.', 'TAAA\nh   \nelll\n ooi\nlnnn\nogge\nn e.\nglr\nei \nsnl\ntei\n .n\nl e\ni .\nn\ne\n.'),
        ('85b96b3f-d00c-4f80-8ca2-c8a5c9216c2d', 'square', 'HEART\nEMBER\nABUSE\nRESIN\nTREND', 'HEART\nEMBER\nABUSE\nRESIN\nTREND'),
        ('b9257625-7a53-4748-8863-e08e9d27071d', 'rectangle', 'FRACTURE\nOUTLINED\nBLOOMING\nSEPTETTE', 'FOBS\nRULE\nATOP\nCLOT\nTIME\nUNIT\nRENT\nEDGE'),
        ('b80badc9-057e-4543-bd07-ce1296a1ea2c', 'triangle', 'T\nEE\nAAA\nSSSS\nEEEEE\nRRRRRR', 'TEASER\n EASER\n  ASER\n   SER\n    ER\n     R'),
        ('76acfd50-5596-4d05-89f1-5116328a7dd9', 'jagged triangle', '11\n2\n3333\n444\n555555\n66666', '123456\n1 3456\n  3456\n  3 56\n    56\n    5');

UPDATE tests
   SET lines = REPLACE(lines, '\n', CHAR(10)),
       expected = REPLACE(expected, '\n', CHAR(10));

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
  list_one TEXT NOT NULL, -- json array
  list_two TEXT NOT NULL, -- json array
  expected TEXT NOT NULL
);

INSERT INTO
  tests (uuid, description, list_one, list_two, expected)
VALUES
  (
    '97319c93-ebc5-47ab-a022-02a1980e1d29',
    'empty lists',
    '[]',
    '[]',
    'equal'
  ),
  (
    'de27dbd4-df52-46fe-a336-30be58457382',
    'empty list within non empty list',
    '[]',
    '[1,2,3]',
    'sublist'
  ),
  (
    '5487cfd1-bc7d-429f-ac6f-1177b857d4fb',
    'non empty list contains empty list',
    '[1,2,3]',
    '[]',
    'superlist'
  ),
  (
    '1f390b47-f6b2-4a93-bc23-858ba5dda9a6',
    'list equals itself',
    '[1,2,3]',
    '[1,2,3]',
    'equal'
  ),
  (
    '7ed2bfb2-922b-4363-ae75-f3a05e8274f5',
    'different lists',
    '[1,2,3]',
    '[2,3,4]',
    'unequal'
  ),
  (
    '3b8a2568-6144-4f06-b0a1-9d266b365341',
    'false start',
    '[1,2,5]',
    '[0,1,2,3,1,2,5,6]',
    'sublist'
  ),
  (
    'dc39ed58-6311-4814-be30-05a64bc8d9b1',
    'consecutive',
    '[1,1,2]',
    '[0,1,1,1,2,1,2]',
    'sublist'
  ),
  (
    'd1270dab-a1ce-41aa-b29d-b3257241ac26',
    'sublist at start',
    '[0,1,2]',
    '[0,1,2,3,4,5]',
    'sublist'
  ),
  (
    '81f3d3f7-4f25-4ada-bcdc-897c403de1b6',
    'sublist in middle',
    '[2,3,4]',
    '[0,1,2,3,4,5]',
    'sublist'
  ),
  (
    '43bcae1e-a9cf-470e-923e-0946e04d8fdd',
    'sublist at end',
    '[3,4,5]',
    '[0,1,2,3,4,5]',
    'sublist'
  ),
  (
    '76cf99ed-0ff0-4b00-94af-4dfb43fe5caa',
    'at start of superlist',
    '[0,1,2,3,4,5]',
    '[0,1,2]',
    'superlist'
  ),
  (
    'b83989ec-8bdf-4655-95aa-9f38f3e357fd',
    'in middle of superlist',
    '[0,1,2,3,4,5]',
    '[2,3]',
    'superlist'
  ),
  (
    '26f9f7c3-6cf6-4610-984a-662f71f8689b',
    'at end of superlist',
    '[0,1,2,3,4,5]',
    '[3,4,5]',
    'superlist'
  ),
  (
    '0a6db763-3588-416a-8f47-76b1cedde31e',
    'first list missing element from second list',
    '[1,3]',
    '[1,2,3]',
    'unequal'
  ),
  (
    '83ffe6d8-a445-4a3c-8795-1e51a95e65c3',
    'second list missing element from first list',
    '[1,2,3]',
    '[1,3]',
    'unequal'
  ),
  (
    '7bc76cb8-5003-49ca-bc47-cdfbe6c2bb89',
    'first list missing additional digits from second list',
    '[1,2]',
    '[1,22]',
    'unequal'
  ),
  (
    '0d7ee7c1-0347-45c8-9ef5-b88db152b30b',
    'order matters to a list',
    '[1,2,3]',
    '[3,2,1]',
    'unequal'
  ),
  (
    '5f47ce86-944e-40f9-9f31-6368aad70aa6',
    'same digits but different numbers',
    '[1,0,1]',
    '[10,1]',
    'unequal'
  );

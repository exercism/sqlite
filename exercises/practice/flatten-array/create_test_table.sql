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
  array TEXT NOT NULL, -- json array
  expected TEXT NOT NULL -- json array
);

INSERT INTO
  tests (uuid, description, array, expected)
VALUES
  (
    '8c71dabd-da60-422d-a290-4a571471fb14',
    'empty',
    '[]',
    '[]'
  ),
  (
    'd268b919-963c-442d-9f07-82b93f1b518c',
    'no nesting',
    '[0,1,2]',
    '[0,1,2]'
  ),
  (
    '3f15bede-c856-479e-bb71-1684b20c6a30',
    'flattens a nested array',
    '[[[]]]',
    '[]'
  ),
  (
    'c84440cc-bb3a-48a6-862c-94cf23f2815d',
    'flattens array with just integers present',
    '[1,[2,3,4,5,6,7],8]',
    '[1,2,3,4,5,6,7,8]'
  ),
  (
    'd3d99d39-6be5-44f5-a31d-6037d92ba34f',
    '5 level nesting',
    '[0,2,[[2,3],8,100,4,[[[50]]]],-2]',
    '[0,2,2,3,8,100,4,50,-2]'
  ),
  (
    'd572bdba-c127-43ed-bdcd-6222ac83d9f7',
    '6 level nesting',
    '[1,[2,[[3]],[4,[[5]]],6,7],8]',
    '[1,2,3,4,5,6,7,8]'
  ),
  (
    '0705a8e5-dc86-4cec-8909-150c5e54fa9c',
    'null values are omitted from the final result',
    '[1,2,null]',
    '[1,2]'
  ),
  (
    'bc72da10-5f55-4ada-baf3-50e4da02ec8e',
    'consecutive null values at the front of the array are omitted from the final result',
    '[null,null,3]',
    '[3]'
  ),
  (
    '6991836d-0d9b-4703-80a0-3f1f23eb5981',
    'consecutive null values in the middle of the array are omitted from the final result',
    '[1,null,null,4]',
    '[1,4]'
  ),
  (
    'dc90a09c-5376-449c-a7b3-c2d20d540069',
    '6 level nested array with null values',
    '[0,2,[[2,3],8,[[100]],null,[[null]]],-2]',
    '[0,2,2,3,8,100,-2]'
  ),
  (
    '51f5d9af-8f7f-4fb5-a156-69e8282cb275',
    'all values in nested array are null',
    '[null,[[[null]]],null,null,[[null,null],null],null]',
    '[]'
  );

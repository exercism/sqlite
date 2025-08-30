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
  database TEXT NOT NULL,
  payload TEXT NOT NULL,
  url TEXT INT NOT NULL,
  expected TEXT NOT NULL
);

-- Note: the strings below _may_ contain literal tab, newline, or carriage returns.
INSERT INTO
  tests (uuid, name, database, payload, url, expected)
VALUES
  (
    '5be01ffb-a814-47a8-a19f-490a5622ba07',
    'no users',
    '{"users":[]}',
    '{}',
    '/users',
    '{"users":[]}'
  ),
  (
    '382b70cc-9f6c-486d-9bee-fda2df81c803',
    'add user',
    '{"users":[]}',
    '{"user":"Adam"}',
    '/add',
    '{"name":"Adam","owes":{},"owed_by":{},"balance":0}'
  ),
  (
    'd624e5e5-1abb-4f18-95b3-45d55c818dc3',
    'get single user',
    '{"users":[{"name":"Adam","owes":{},"owed_by":{},"balance":0},{"name":"Bob","owes":{},"owed_by":{},"balance":0}]}',
    '{"users":["Bob"]}',
    '/users',
    '{"users":[{"name":"Bob","owes":{},"owed_by":{},"balance":0}]}'
  ),
  (
    '7a81b82c-7276-433e-8fce-29ce983a7c56',
    'both users have 0 balance',
    '{"users":[{"name":"Adam","owes":{},"owed_by":{},"balance":0},{"name":"Bob","owes":{},"owed_by":{},"balance":0}]}',
    '{"lender":"Adam","borrower":"Bob","amount":3}',
    '/iou',
    '{"users":[{"name":"Adam","owes":{},"owed_by":{"Bob":3},"balance":3},{"name":"Bob","owes":{"Adam":3},"owed_by":{},"balance":-3}]}'
  ),
  (
    '1c61f957-cf8c-48ba-9e77-b221ab068803',
    'borrower has negative balance',
    '{"users":[{"name":"Adam","owes":{},"owed_by":{},"balance":0},{"name":"Bob","owes":{"Chuck":3},"owed_by":{},"balance":-3},{"name":"Chuck","owes":{},"owed_by":{"Bob":3},"balance":3}]}',
    '{"lender":"Adam","borrower":"Bob","amount":3}',
    '/iou',
    '{"users":[{"name":"Adam","owes":{},"owed_by":{"Bob":3},"balance":3},{"name":"Bob","owes":{"Adam":3,"Chuck":3},"owed_by":{},"balance":-6}]}'
  ),
  (
    '8a8567b3-c097-468a-9541-6bb17d5afc85',
    'lender has negative balance',
    '{"users":[{"name":"Adam","owes":{},"owed_by":{},"balance":0},{"name":"Bob","owes":{"Chuck":3},"owed_by":{},"balance":-3},{"name":"Chuck","owes":{},"owed_by":{"Bob":3},"balance":3}]}',
    '{"lender":"Bob","borrower":"Adam","amount":3}',
    '/iou',
    '{"users":[{"name":"Adam","owes":{"Bob":3},"owed_by":{},"balance":-3},{"name":"Bob","owes":{"Chuck":3},"owed_by":{"Adam":3},"balance":0}]}'
  ),
  (
    '29fb7c12-7099-4a85-a7c4-9c290d2dc01a',
    'lender owes borrower',
    '{"users":[{"name":"Adam","owes":{"Bob":3},"owed_by":{},"balance":-3},{"name":"Bob","owes":{},"owed_by":{"Adam":3},"balance":3}]}',
    '{"lender":"Adam","borrower":"Bob","amount":2}',
    '/iou',
    '{"users":[{"name":"Adam","owes":{"Bob":1},"owed_by":{},"balance":-1},{"name":"Bob","owes":{},"owed_by":{"Adam":1},"balance":1}]}'
  ),
  (
    'ce969e70-163c-4135-a4a6-2c3a5da286f5',
    'lender owes borrower less than new loan',
    '{"users":[{"name":"Adam","owes":{"Bob":3},"owed_by":{},"balance":-3},{"name":"Bob","owes":{},"owed_by":{"Adam":3},"balance":3}]}',
    '{"lender":"Adam","borrower":"Bob","amount":4}',
    '/iou',
    '{"users":[{"name":"Adam","owes":{},"owed_by":{"Bob":1},"balance":1},{"name":"Bob","owes":{"Adam":1},"owed_by":{},"balance":-1}]}'
  ),
  (
    '7f4aafd9-ae9b-4e15-a406-87a87bdf47a4',
    'lender owes borrower same as new loan',
    '{"users":[{"name":"Adam","owes":{"Bob":3},"owed_by":{},"balance":-3},{"name":"Bob","owes":{},"owed_by":{"Adam":3},"balance":3}]}',
    '{"lender":"Adam","borrower":"Bob","amount":3}',
    '/iou',
    '{"users":[{"name":"Adam","owes":{},"owed_by":{},"balance":0},{"name":"Bob","owes":{},"owed_by":{},"balance":0}]}'
  );

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
    input TEXT NOT NULL,
    expected TEXT NOT NULL
);

INSERT INTO tests (uuid, description, input, expected)
    VALUES
        ('67e9fab1-07c1-49cf-9159-bc8671cc7c9c', 'just the header if no input', '', 'Team                           | MP |  W |  D |  L |  P'),
        ('1b4a8aef-0734-4007-80a2-0626178c88f4', 'a win is three points, a loss is zero points', 'Allegoric Alaskans;Blithering Badgers;win', 'Team                           | MP |  W |  D |  L |  P\nAllegoric Alaskans             |  1 |  1 |  0 |  0 |  3\nBlithering Badgers             |  1 |  0 |  0 |  1 |  0'),
        ('5f45ac09-4efe-46e7-8ddb-75ad85f86e05', 'a win can also be expressed as a loss', 'Blithering Badgers;Allegoric Alaskans;loss', 'Team                           | MP |  W |  D |  L |  P\nAllegoric Alaskans             |  1 |  1 |  0 |  0 |  3\nBlithering Badgers             |  1 |  0 |  0 |  1 |  0'),
        ('fd297368-efa0-442d-9f37-dd3f9a437239', 'a different team can win', 'Blithering Badgers;Allegoric Alaskans;win', 'Team                           | MP |  W |  D |  L |  P\nBlithering Badgers             |  1 |  1 |  0 |  0 |  3\nAllegoric Alaskans             |  1 |  0 |  0 |  1 |  0'),
        ('26c016f9-e753-4a93-94e9-842f7b4d70fc', 'a draw is one point each', 'Allegoric Alaskans;Blithering Badgers;draw', 'Team                           | MP |  W |  D |  L |  P\nAllegoric Alaskans             |  1 |  0 |  1 |  0 |  1\nBlithering Badgers             |  1 |  0 |  1 |  0 |  1'),
        ('731204f6-4f34-4928-97eb-1c307ba83e62', 'There can be more than one match', 'Allegoric Alaskans;Blithering Badgers;win\nAllegoric Alaskans;Blithering Badgers;win', 'Team                           | MP |  W |  D |  L |  P\nAllegoric Alaskans             |  2 |  2 |  0 |  0 |  6\nBlithering Badgers             |  2 |  0 |  0 |  2 |  0'),
        ('49dc2463-42af-4ea6-95dc-f06cc5776adf', 'There can be more than one winner', 'Allegoric Alaskans;Blithering Badgers;loss\nAllegoric Alaskans;Blithering Badgers;win', 'Team                           | MP |  W |  D |  L |  P\nAllegoric Alaskans             |  2 |  1 |  0 |  1 |  3\nBlithering Badgers             |  2 |  1 |  0 |  1 |  3'),
        ('6d930f33-435c-4e6f-9e2d-63fa85ce7dc7', 'There can be more than two teams', 'Allegoric Alaskans;Blithering Badgers;win\nBlithering Badgers;Courageous Californians;win\nCourageous Californians;Allegoric Alaskans;loss', 'Team                           | MP |  W |  D |  L |  P\nAllegoric Alaskans             |  2 |  2 |  0 |  0 |  6\nBlithering Badgers             |  2 |  1 |  0 |  1 |  3\nCourageous Californians        |  2 |  0 |  0 |  2 |  0'),
        ('97022974-0c8a-4a50-8fe7-e36bdd8a5945', 'typical input', 'Allegoric Alaskans;Blithering Badgers;win\nDevastating Donkeys;Courageous Californians;draw\nDevastating Donkeys;Allegoric Alaskans;win\nCourageous Californians;Blithering Badgers;loss\nBlithering Badgers;Devastating Donkeys;loss\nAllegoric Alaskans;Courageous Californians;win', 'Team                           | MP |  W |  D |  L |  P\nDevastating Donkeys            |  3 |  2 |  1 |  0 |  7\nAllegoric Alaskans             |  3 |  2 |  0 |  1 |  6\nBlithering Badgers             |  3 |  1 |  0 |  2 |  3\nCourageous Californians        |  3 |  0 |  1 |  2 |  1'),
        ('fe562f0d-ac0a-4c62-b9c9-44ee3236392b', 'incomplete competition (not all pairs have played)', 'Allegoric Alaskans;Blithering Badgers;loss\nDevastating Donkeys;Allegoric Alaskans;loss\nCourageous Californians;Blithering Badgers;draw\nAllegoric Alaskans;Courageous Californians;win', 'Team                           | MP |  W |  D |  L |  P\nAllegoric Alaskans             |  3 |  2 |  0 |  1 |  6\nBlithering Badgers             |  2 |  1 |  1 |  0 |  4\nCourageous Californians        |  2 |  0 |  1 |  1 |  1\nDevastating Donkeys            |  1 |  0 |  0 |  1 |  0'),
        ('3aa0386f-150b-4f99-90bb-5195e7b7d3b8', 'ties broken alphabetically', 'Courageous Californians;Devastating Donkeys;win\nAllegoric Alaskans;Blithering Badgers;win\nDevastating Donkeys;Allegoric Alaskans;loss\nCourageous Californians;Blithering Badgers;win\nBlithering Badgers;Devastating Donkeys;draw\nAllegoric Alaskans;Courageous Californians;draw', 'Team                           | MP |  W |  D |  L |  P\nAllegoric Alaskans             |  3 |  2 |  1 |  0 |  7\nCourageous Californians        |  3 |  2 |  1 |  0 |  7\nBlithering Badgers             |  3 |  0 |  1 |  2 |  1\nDevastating Donkeys            |  3 |  0 |  1 |  2 |  1'),
        ('f9e20931-8a65-442a-81f6-503c0205b17a', 'ensure points sorted numerically', 'Devastating Donkeys;Blithering Badgers;win\nDevastating Donkeys;Blithering Badgers;win\nDevastating Donkeys;Blithering Badgers;win\nDevastating Donkeys;Blithering Badgers;win\nBlithering Badgers;Devastating Donkeys;win', 'Team                           | MP |  W |  D |  L |  P\nDevastating Donkeys            |  5 |  4 |  0 |  1 | 12\nBlithering Badgers             |  5 |  1 |  0 |  4 |  3');

UPDATE tests SET input    = REPLACE(input,    '\n', CHAR(10));
UPDATE tests SET expected = REPLACE(expected, '\n', CHAR(10));

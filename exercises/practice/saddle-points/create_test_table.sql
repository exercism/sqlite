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
    matrix TEXT NOT NULL,     -- json array of arrays
    expected TEXT NOT NULL    -- json array of objects
);

INSERT INTO tests (uuid, description, matrix, expected)
VALUES
        ('3e374e63-a2e0-4530-a39a-d53c560382bd', 'Can identify single saddle point', '[[9,8,7],[5,3,2],[6,6,7]]', '[{"row":2,"column":1}]'),
        ('6b501e2b-6c1f-491f-b1bb-7f278f760534', 'Can identify that empty matrix has no saddle points', '[[]]', '[]'),
        ('8c27cc64-e573-4fcb-a099-f0ae863fb02f', 'Can identify lack of saddle points when there are none', '[[1,2,3],[3,1,2],[2,3,1]]', '[]'),
        ('6d1399bd-e105-40fd-a2c9-c6609507d7a3', 'Can identify multiple saddle points in a column', '[[4,5,4],[3,5,5],[1,5,4]]', '[{"row":1,"column":2},{"row":2,"column":2},{"row":3,"column":2}]'),
        ('3e81dce9-53b3-44e6-bf26-e328885fd5d1', 'Can identify multiple saddle points in a row', '[[6,7,8],[5,5,5],[7,5,6]]', '[{"row":2,"column":1},{"row":2,"column":2},{"row":2,"column":3}]'),
        ('88868621-b6f4-4837-bb8b-3fad8b25d46b', 'Can identify saddle point in bottom right corner', '[[8,7,9],[6,7,6],[3,2,5]]', '[{"row":3,"column":3}]'),
        ('5b9499ca-fcea-4195-830a-9c4584a0ee79', 'Can identify saddle points in a non square matrix', '[[3,1,3],[3,2,4]]', '[{"row":1,"column":3},{"row":1,"column":1}]'),
        ('ee99ccd2-a1f1-4283-ad39-f8c70f0cf594', 'Can identify that saddle points in a single column matrix are those with the minimum value', '[[2],[1],[4],[1]]', '[{"row":2,"column":1},{"row":4,"column":1}]'),
        ('63abf709-a84b-407f-a1b3-456638689713', 'Can identify that saddle points in a single row matrix are those with the maximum value', '[[2,5,3,5]]', '[{"row":1,"column":2},{"row":1,"column":4}]');

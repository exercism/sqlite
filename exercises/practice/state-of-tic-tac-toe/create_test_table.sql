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
    board TEXT NOT NULL,
    expected_result TEXT,
    expected_error TEXT
);

INSERT INTO tests (uuid, description, board, expected_result, expected_error)
    VALUES
        ('fe8e9fa9-37af-4d7e-aa24-2f4b8517161a', 'Finished game where X won via left column victory', 'XOO\nX  \nX  ', 'win', NULL),
        ('96c30df5-ae23-4cf6-bf09-5ef056dddea1', 'Finished game where X won via middle column victory', 'OXO\n X \n X ', 'win', NULL),
        ('0d7a4b0a-2afd-4a75-8389-5fb88ab05eda', 'Finished game where X won via right column victory', 'OOX\n  X\n  X', 'win', NULL),
        ('bd1007c0-ec5d-4c60-bb9f-1a4f22177d51', 'Finished game where O won via left column victory', 'OXX\nOX \nO  ', 'win', NULL),
        ('c032f800-5735-4354-b1b9-46f14d4ee955', 'Finished game where O won via middle column victory', 'XOX\n OX\n O ', 'win', NULL),
        ('662c8902-c94a-4c4c-9d9c-e8ca513db2b4', 'Finished game where O won via right column victory', 'XXO\n XO\n  O', 'win', NULL),
        ('2d62121f-7e3a-44a0-9032-0d73e3494941', 'Finished game where X won via top row victory', 'XXX\nXOO\nO  ', 'win', NULL),
        ('346527db-4db9-4a96-b262-d7023dc022b0', 'Finished game where X won via middle row victory', 'O  \nXXX\n O ', 'win', NULL),
        ('a013c583-75f8-4ab2-8d68-57688ff04574', 'Finished game where X won via bottom row victory', ' OO\nO X\nXXX', 'win', NULL),
        ('2c08e7d7-7d00-487f-9442-e7398c8f1727', 'Finished game where O won via top row victory', 'OOO\nXXO\nXX ', 'win', NULL),
        ('bb1d6c62-3e3f-4d1a-9766-f8803c8ed70f', 'Finished game where O won via middle row victory', 'XX \nOOO\nX  ', 'win', NULL),
        ('6ef641e9-12ec-44f5-a21c-660ea93907af', 'Finished game where O won via bottom row victory', 'XOX\n XX\nOOO', 'win', NULL),
        ('ab145b7b-26a7-426c-ab71-bf418cd07f81', 'Finished game where X won via falling diagonal victory', 'XOO\n X \n  X', 'win', NULL),
        ('7450caab-08f5-4f03-a74b-99b98c4b7a4b', 'Finished game where X won via rising diagonal victory', 'O X\nOX \nX  ', 'win', NULL),
        ('c2a652ee-2f93-48aa-a710-a70cd2edce61', 'Finished game where O won via falling diagonal victory', 'OXX\nOOX\nX O', 'win', NULL),
        ('5b20ceea-494d-4f0c-a986-b99efc163bcf', 'Finished game where O won via rising diagonal victory', '  O\n OX\nOXX', 'win', NULL),
        ('035a49b9-dc35-47d3-9d7c-de197161b9d4', 'Finished game where X won via a row and a column victory', 'XXX\nXOO\nXOO', 'win', NULL),
        ('e5dfdeb0-d2bf-4b5a-b307-e673f69d4a53', 'Finished game where X won via two diagonal victories', 'XOX\nOXO\nXOX', 'win', NULL),
        ('b42ed767-194c-4364-b36e-efbfb3de8788', 'Draw', 'XOX\nXXO\nOXO', 'draw', NULL),
        ('227a76b2-0fef-4e16-a4bd-8f9d7e4c3b13', 'Another draw', 'XXO\nOXX\nXOO', 'draw', NULL),
        ('4d93f15c-0c40-43d6-b966-418b040012a9', 'Ongoing game: one move in', '   \nX  \n   ', 'ongoing', NULL),
        ('c407ae32-4c44-4989-b124-2890cf531f19', 'Ongoing game: two moves in', 'O  \n X \n   ', 'ongoing', NULL),
        ('199b7a8d-e2b6-4526-a85e-78b416e7a8a9', 'Ongoing game: five moves in', 'X  \n XO\nOX ', 'ongoing', NULL),
        ('1670145b-1e3d-4269-a7eb-53cd327b302e', 'Invalid board: X went twice', 'XX \n   \n   ', NULL, 'Wrong turn order: X went twice'),
        ('47c048e8-b404-4bcf-9e51-8acbb3253f3b', 'Invalid board: O started', 'OOX\n   \n   ', NULL, 'Wrong turn order: O started'),
        ('6c1920f2-ab5c-4648-a0c9-997414dda5eb', 'Invalid board: X won and O kept playing', 'XXX\nOOO\n   ', NULL, 'Impossible board: game should have ended after the game was won'),
        ('4801cda2-f5b7-4c36-8317-3cdd167ac22c', 'Invalid board: players kept playing after a win', 'XXX\nOOO\nXOX', NULL, 'Impossible board: game should have ended after the game was won');

UPDATE tests SET board = REPLACE(board, '\n', CHAR(10));

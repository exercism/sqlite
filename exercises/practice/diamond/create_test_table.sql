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
  letter TEXT NOT NULL,
  expected TEXT NOT NULL
);

INSERT INTO tests (uuid, description, letter, expected)
VALUES
('202fb4cc-6a38-4883-9193-a29d5cb92076', 'Degenerate case with a single ''A'' row', 'A', 'A'),
('bd6a6d78-9302-42e9-8f60-ac1461e9abae', 'Degenerate case with no row containing 3 distinct groups of spaces', 'B', ' A \nB B\n A '),
('af8efb49-14ed-447f-8944-4cc59ce3fd76', 'Smallest non-degenerate case with odd diamond side length', 'C', '  A  \n B B \nC   C\n B B \n  A  '),
('e0c19a95-9888-4d05-86a0-fa81b9e70d1d', 'Smallest non-degenerate case with even diamond side length', 'D', '   A   \n  B B  \n C   C \nD     D\n C   C \n  B B  \n   A   '),
('82ea9aa9-4c0e-442a-b07e-40204e925944', 'Largest possible diamond', 'Z', '                         A                         \n                        B B                        \n                       C   C                       \n                      D     D                      \n                     E       E                     \n                    F         F                    \n                   G           G                   \n                  H             H                  \n                 I               I                 \n                J                 J                \n               K                   K               \n              L                     L              \n             M                       M             \n            N                         N            \n           O                           O           \n          P                             P          \n         Q                               Q         \n        R                                 R        \n       S                                   S       \n      T                                     T      \n     U                                       U     \n    V                                         V    \n   W                                           W   \n  X                                             X  \n Y                                               Y \nZ                                                 Z\n Y                                               Y \n  X                                             X  \n   W                                           W   \n    V                                         V    \n     U                                       U     \n      T                                     T      \n       S                                   S       \n        R                                 R        \n         Q                               Q         \n          P                             P          \n           O                           O           \n            N                         N            \n             M                       M             \n              L                     L              \n               K                   K               \n                J                 J                \n                 I               I                 \n                  H             H                  \n                   G           G                   \n                    F         F                    \n                     E       E                     \n                      D     D                      \n                       C   C                       \n                        B B                        \n                         A                         ');

UPDATE tests SET expected = REPLACE(expected, '\n', CHAR(10));

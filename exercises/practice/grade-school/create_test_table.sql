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
  property TEXT NOT NULL,
  input TEXT NOT NULL,          -- json object
  expected TEXT NOT NULL        -- json array
);

INSERT INTO tests (uuid, description, property, input, expected)
VALUES
('a3f0fb58-f240-4723-8ddc-e644666b85cc', 'Roster is empty when no student is added', 'roster', '{"students":[]}', '[]'),
('9337267f-7793-4b90-9b4a-8e3978408824', 'Add a student', 'add', '{"students":[["Aimee",2]]}', '[true]'),
('6d0a30e4-1b4e-472e-8e20-c41702125667', 'Student is added to the roster', 'roster', '{"students":[["Aimee",2]]}', '["Aimee"]'),
('73c3ca75-0c16-40d7-82f5-ed8fe17a8e4a', 'Adding multiple students in the same grade in the roster', 'add', '{"students":[["Blair",2],["James",2],["Paul",2]]}', '[true,true,true]'),
('233be705-dd58-4968-889d-fb3c7954c9cc', 'Multiple students in the same grade are added to the roster', 'roster', '{"students":[["Blair",2],["James",2],["Paul",2]]}', '["Blair","James","Paul"]'),
('87c871c1-6bde-4413-9c44-73d59a259d83', 'Cannot add student to same grade in the roster more than once', 'add', '{"students":[["Blair",2],["James",2],["James",2],["Paul",2]]}', '[true,true,false,true]'),
('d7982c4f-1602-49f6-a651-620f2614243a', 'Student not added to same grade in the roster more than once', 'roster', '{"students":[["Blair",2],["James",2],["James",2],["Paul",2]]}', '["Blair","James","Paul"]'),
('e70d5d8f-43a9-41fd-94a4-1ea0fa338056', 'Adding students in multiple grades', 'add', '{"students":[["Chelsea",3],["Logan",7]]}', '[true,true]'),
('75a51579-d1d7-407c-a2f8-2166e984e8ab', 'Students in multiple grades are added to the roster', 'roster', '{"students":[["Chelsea",3],["Logan",7]]}', '["Chelsea","Logan"]'),
('7df542f1-57ce-433c-b249-ff77028ec479', 'Cannot add same student to multiple grades in the roster', 'add', '{"students":[["Blair",2],["James",2],["James",3],["Paul",3]]}', '[true,true,false,true]'),
('c7ec1c5e-9ab7-4d3b-be5c-29f2f7a237c5', 'Student not added to multiple grades in the roster', 'roster', '{"students":[["Blair",2],["James",2],["James",3],["Paul",3]]}', '["Blair","James","Paul"]'),
('d9af4f19-1ba1-48e7-94d0-dabda4e5aba6', 'Students are sorted by grades in the roster', 'roster', '{"students":[["Jim",3],["Peter",2],["Anna",1]]}', '["Anna","Peter","Jim"]'),
('d9fb5bea-f5aa-4524-9d61-c158d8906807', 'Students are sorted by name in the roster', 'roster', '{"students":[["Peter",2],["Zoe",2],["Alex",2]]}', '["Alex","Peter","Zoe"]'),
('180a8ff9-5b94-43fc-9db1-d46b4a8c93b6', 'Students are sorted by grades and then by name in the roster', 'roster', '{"students":[["Peter",2],["Anna",1],["Barb",1],["Zoe",2],["Alex",2],["Jim",3],["Charlie",1]]}', '["Anna","Barb","Charlie","Alex","Peter","Zoe","Jim"]'),
('5e67aa3c-a3c6-4407-a183-d8fe59cd1630', 'Grade is empty if no students in the roster', 'grade', '{"students":[],"desiredGrade":1}', '[]'),
('1e0cf06b-26e0-4526-af2d-a2e2df6a51d6', 'Grade is empty if no students in that grade', 'grade', '{"students":[["Peter",2],["Zoe",2],["Alex",2],["Jim",3]],"desiredGrade":1}', '[]'),
('2bfc697c-adf2-4b65-8d0f-c46e085f796e', 'Student not added to same grade more than once', 'grade', '{"students":[["Blair",2],["James",2],["James",2],["Paul",2]],"desiredGrade":2}', '["Blair","James","Paul"]'),
('66c8e141-68ab-4a04-a15a-c28bc07fe6b9', 'Student not added to multiple grades', 'grade', '{"students":[["Blair",2],["James",2],["James",3],["Paul",3]],"desiredGrade":2}', '["Blair","James"]'),
('c9c1fc2f-42e0-4d2c-b361-99271f03eda7', 'Student not added to other grade for multiple grades', 'grade', '{"students":[["Blair",2],["James",2],["James",3],["Paul",3]],"desiredGrade":3}', '["Paul"]'),
('1bfbcef1-e4a3-49e8-8d22-f6f9f386187e', 'Students are sorted by name in a grade', 'grade', '{"students":[["Franklin",5],["Bradley",5],["Jeff",1]],"desiredGrade":5}', '["Bradley","Franklin"]');

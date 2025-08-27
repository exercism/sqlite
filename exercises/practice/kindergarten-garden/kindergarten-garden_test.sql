-- Setup test table and read in student solution:
.read ./test_setup.sql
-- Test cases:
INSERT INTO
  tests (name, uuid, diagram, student, expected)
VALUES
  (
    'garden with single student',
    '1fc316ed-17ab-4fba-88ef-3ae78296b692',
    'RC' || char(10) || 'GG',
    'Alice',
    'radishes,clover,grass,grass'
  ),
  (
    'different garden with single student',
    'acd19dc1-2200-4317-bc2a-08f021276b40',
    'VC' || char(10) || 'RC',
    'Alice',
    'violets,clover,radishes,clover'
  ),
  (
    'garden with two students',
    'c376fcc8-349c-446c-94b0-903947315757',
    'VVCG' || char(10) || 'VVRC',
    'Bob',
    'clover,grass,radishes,clover'
  ),
  (
    'second student''s garden',
    '2d620f45-9617-4924-9d27-751c80d17db9',
    'VVCCGG' || char(10) || 'VVCCGG',
    'Bob',
    'clover,clover,clover,clover'
  ),
  (
    'third student''s garden',
    '57712331-4896-4364-89f8-576421d69c44',
    'VVCCGG' || char(10) || 'VVCCGG',
    'Charlie',
    'grass,grass,grass,grass'
  ),
  (
    'for Alice, first student''s garden',
    '149b4290-58e1-40f2-8ae4-8b87c46e765b',
    'VRCGVVRVCGGCCGVRGCVCGCGV' || char(10) || 'VRCCCGCRRGVCGCRVVCVGCGCV',
    'Alice',
    'violets,radishes,violets,radishes'
  ),
  (
    'for Bob, second student''s garden',
    'ba25dbbc-10bd-4a37-b18e-f89ecd098a5e',
    'VRCGVVRVCGGCCGVRGCVCGCGV' || char(10) || 'VRCCCGCRRGVCGCRVVCVGCGCV',
    'Bob',
    'clover,grass,clover,clover'
  ),
  (
    'for Charlie',
    '566b621b-f18e-4c5f-873e-be30544b838c',
    'VRCGVVRVCGGCCGVRGCVCGCGV' || char(10) || 'VRCCCGCRRGVCGCRVVCVGCGCV',
    'Charlie',
    'violets,violets,clover,grass'
  ),
  (
    'for David',
    '3ad3df57-dd98-46fc-9269-1877abf612aa',
    'VRCGVVRVCGGCCGVRGCVCGCGV' || char(10) || 'VRCCCGCRRGVCGCRVVCVGCGCV',
    'David',
    'radishes,violets,clover,radishes'
  ),
  (
    'for Eve',
    '0f0a55d1-9710-46ed-a0eb-399ba8c72db2',
    'VRCGVVRVCGGCCGVRGCVCGCGV' || char(10) || 'VRCCCGCRRGVCGCRVVCVGCGCV',
    'Eve',
    'clover,grass,radishes,grass'
  ),
  (
    'for Fred',
    'a7e80c90-b140-4ea1-aee3-f4625365c9a4',
    'VRCGVVRVCGGCCGVRGCVCGCGV' || char(10) || 'VRCCCGCRRGVCGCRVVCVGCGCV',
    'Fred',
    'grass,clover,violets,clover'
  ),
  (
    'for Ginny',
    '9d94b273-2933-471b-86e8-dba68694c615',
    'VRCGVVRVCGGCCGVRGCVCGCGV' || char(10) || 'VRCCCGCRRGVCGCRVVCVGCGCV',
    'Ginny',
    'clover,grass,grass,clover'
  ),
  (
    'for Harriet',
    'f55bc6c2-ade8-4844-87c4-87196f1b7258',
    'VRCGVVRVCGGCCGVRGCVCGCGV' || char(10) || 'VRCCCGCRRGVCGCRVVCVGCGCV',
    'Harriet',
    'violets,radishes,radishes,violets'
  ),
  (
    'for Ileana',
    '759070a3-1bb1-4dd4-be2c-7cce1d7679ae',
    'VRCGVVRVCGGCCGVRGCVCGCGV' || char(10) || 'VRCCCGCRRGVCGCRVVCVGCGCV',
    'Ileana',
    'grass,clover,violets,clover'
  ),
  (
    'for Joseph',
    '78578123-2755-4d4a-9c7d-e985b8dda1c6',
    'VRCGVVRVCGGCCGVRGCVCGCGV' || char(10) || 'VRCCCGCRRGVCGCRVVCVGCGCV',
    'Joseph',
    'violets,clover,violets,grass'
  ),
  (
    'for Kincaid, second to last student''s garden',
    '6bb66df7-f433-41ab-aec2-3ead6e99f65b',
    'VRCGVVRVCGGCCGVRGCVCGCGV' || char(10) || 'VRCCCGCRRGVCGCRVVCVGCGCV',
    'Kincaid',
    'grass,clover,clover,grass'
  ),
  (
    'for Larry, last student''s garden',
    'd7edec11-6488-418a-94e6-ed509e0fa7eb',
    'VRCGVVRVCGGCCGVRGCVCGCGV' || char(10) || 'VRCCCGCRRGVCGCRVVCVGCGCV',
    'Larry',
    'grass,violets,clover,violets'
  );

-- Comparison of user input and the tests updates the status for each test:
UPDATE tests
SET
  status = 'pass'
FROM
  (
    SELECT
      diagram,
      student,
      result
    FROM
      "kindergarten-garden"
  ) AS actual
WHERE
  (actual.diagram, actual.student, actual.result) = (tests.diagram, tests.student, tests.expected);

-- Write results and debug info:
.read ./test_reporter.sql

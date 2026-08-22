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

INSERT INTO
  tests (uuid, description, lines, expected)
VALUES
  (
    '404b7262-c050-4df0-a2a2-0cb06cd6a821',
    'empty string',
    '',
    ''
  ),
  (
    'a89ce8a3-c940-4703-a688-3ea39412fbcb',
    'two characters in a row',
    'A1',
    'A
1'
  ),
  (
    '855bb6ae-4180-457c-abd0-ce489803ce98',
    'two characters in a column',
    'A
1',
    'A1'
  ),
  (
    '5ceda1c0-f940-441c-a244-0ced197769c8',
    'simple',
    'ABC
123',
    'A1
B2
C3'
  ),
  (
    'a54675dd-ae7d-4a58-a9c4-0c20e99a7c1f',
    'single line',
    'Single line.',
    'S
i
n
g
l
e
 
l
i
n
e
.'
  ),
  (
    '0dc2ec0b-549d-4047-aeeb-8029fec8d5c5',
    'first line longer than second line',
    'The fourth line.
The fifth line.',
    'TT
hh
ee
  
ff
oi
uf
rt
th
h 
 l
li
in
ne
e.
.'
  ),
  (
    '984e2ec3-b3d3-4b53-8bd6-96f5ef404102',
    'second line longer than first line',
    'The first line.
The second line.',
    'TT
hh
ee
  
fs
ie
rc
so
tn
 d
l 
il
ni
en
.e
 .'
  ),
  (
    'eccd3784-45f0-4a3f-865a-360cb323d314',
    'mixed line length',
    'The longest line.
A long line.
A longer line.
A line.',
    'TAAA
h   
elll
 ooi
lnnn
ogge
n e.
glr
ei 
snl
tei
 .n
l e
i .
n
e
.'
  ),
  (
    '85b96b3f-d00c-4f80-8ca2-c8a5c9216c2d',
    'square',
    'HEART
EMBER
ABUSE
RESIN
TREND',
    'HEART
EMBER
ABUSE
RESIN
TREND'
  ),
  (
    'b9257625-7a53-4748-8863-e08e9d27071d',
    'rectangle',
    'FRACTURE
OUTLINED
BLOOMING
SEPTETTE',
    'FOBS
RULE
ATOP
CLOT
TIME
UNIT
RENT
EDGE'
  ),
  (
    'b80badc9-057e-4543-bd07-ce1296a1ea2c',
    'triangle',
    'T
EE
AAA
SSSS
EEEEE
RRRRRR',
    'TEASER
 EASER
  ASER
   SER
    ER
     R'
  ),
  (
    '76acfd50-5596-4d05-89f1-5116328a7dd9',
    'jagged triangle',
    '11
2
3333
444
555555
66666',
    '123456
1 3456
  3456
  3 56
    56
    5'
  );

UPDATE tests
SET
  lines = REPLACE(lines, '\n', CHAR(10)),
  expected = REPLACE(expected, '\n', CHAR(10));

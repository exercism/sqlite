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
  start_verse INTEGER NOT NULL,
  end_verse INTEGER NOT NULL,
  expected TEXT NOT NULL
);

INSERT INTO
  tests (
    uuid,
    description,
    start_verse,
    end_verse,
    expected
  )
VALUES
  (
    '751dce68-9412-496e-b6e8-855998c56166',
    'fly',
    1,
    1,
    'I know an old lady who swallowed a fly.\nI don''t know why she swallowed the fly. Perhaps she''ll die.'
  ),
  (
    '6c56f861-0c5e-4907-9a9d-b2efae389379',
    'spider',
    2,
    2,
    'I know an old lady who swallowed a spider.\nIt wriggled and jiggled and tickled inside her.\nShe swallowed the spider to catch the fly.\nI don''t know why she swallowed the fly. Perhaps she''ll die.'
  ),
  (
    '3edf5f33-bef1-4e39-ae67-ca5eb79203fa',
    'bird',
    3,
    3,
    'I know an old lady who swallowed a bird.\nHow absurd to swallow a bird!\nShe swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.\nShe swallowed the spider to catch the fly.\nI don''t know why she swallowed the fly. Perhaps she''ll die.'
  ),
  (
    'e866a758-e1ff-400e-9f35-f27f28cc288f',
    'cat',
    4,
    4,
    'I know an old lady who swallowed a cat.\nImagine that, to swallow a cat!\nShe swallowed the cat to catch the bird.\nShe swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.\nShe swallowed the spider to catch the fly.\nI don''t know why she swallowed the fly. Perhaps she''ll die.'
  ),
  (
    '3f02c30e-496b-4b2a-8491-bc7e2953cafb',
    'dog',
    5,
    5,
    'I know an old lady who swallowed a dog.\nWhat a hog, to swallow a dog!\nShe swallowed the dog to catch the cat.\nShe swallowed the cat to catch the bird.\nShe swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.\nShe swallowed the spider to catch the fly.\nI don''t know why she swallowed the fly. Perhaps she''ll die.'
  ),
  (
    '4b3fd221-01ea-46e0-825b-5734634fbc59',
    'goat',
    6,
    6,
    'I know an old lady who swallowed a goat.\nJust opened her throat and swallowed a goat!\nShe swallowed the goat to catch the dog.\nShe swallowed the dog to catch the cat.\nShe swallowed the cat to catch the bird.\nShe swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.\nShe swallowed the spider to catch the fly.\nI don''t know why she swallowed the fly. Perhaps she''ll die.'
  ),
  (
    '1b707da9-7001-4fac-941f-22ad9c7a65d4',
    'cow',
    7,
    7,
    'I know an old lady who swallowed a cow.\nI don''t know how she swallowed a cow!\nShe swallowed the cow to catch the goat.\nShe swallowed the goat to catch the dog.\nShe swallowed the dog to catch the cat.\nShe swallowed the cat to catch the bird.\nShe swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.\nShe swallowed the spider to catch the fly.\nI don''t know why she swallowed the fly. Perhaps she''ll die.'
  ),
  (
    '3cb10d46-ae4e-4d2c-9296-83c9ffc04cdc',
    'horse',
    8,
    8,
    'I know an old lady who swallowed a horse.\nShe''s dead, of course!'
  ),
  (
    '22b863d5-17e4-4d1e-93e4-617329a5c050',
    'multiple verses',
    1,
    3,
    'I know an old lady who swallowed a fly.\nI don''t know why she swallowed the fly. Perhaps she''ll die.\n\nI know an old lady who swallowed a spider.\nIt wriggled and jiggled and tickled inside her.\nShe swallowed the spider to catch the fly.\nI don''t know why she swallowed the fly. Perhaps she''ll die.\n\nI know an old lady who swallowed a bird.\nHow absurd to swallow a bird!\nShe swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.\nShe swallowed the spider to catch the fly.\nI don''t know why she swallowed the fly. Perhaps she''ll die.'
  ),
  (
    'e626b32b-745c-4101-bcbd-3b13456893db',
    'full song',
    1,
    8,
    'I know an old lady who swallowed a fly.\nI don''t know why she swallowed the fly. Perhaps she''ll die.\n\nI know an old lady who swallowed a spider.\nIt wriggled and jiggled and tickled inside her.\nShe swallowed the spider to catch the fly.\nI don''t know why she swallowed the fly. Perhaps she''ll die.\n\nI know an old lady who swallowed a bird.\nHow absurd to swallow a bird!\nShe swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.\nShe swallowed the spider to catch the fly.\nI don''t know why she swallowed the fly. Perhaps she''ll die.\n\nI know an old lady who swallowed a cat.\nImagine that, to swallow a cat!\nShe swallowed the cat to catch the bird.\nShe swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.\nShe swallowed the spider to catch the fly.\nI don''t know why she swallowed the fly. Perhaps she''ll die.\n\nI know an old lady who swallowed a dog.\nWhat a hog, to swallow a dog!\nShe swallowed the dog to catch the cat.\nShe swallowed the cat to catch the bird.\nShe swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.\nShe swallowed the spider to catch the fly.\nI don''t know why she swallowed the fly. Perhaps she''ll die.\n\nI know an old lady who swallowed a goat.\nJust opened her throat and swallowed a goat!\nShe swallowed the goat to catch the dog.\nShe swallowed the dog to catch the cat.\nShe swallowed the cat to catch the bird.\nShe swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.\nShe swallowed the spider to catch the fly.\nI don''t know why she swallowed the fly. Perhaps she''ll die.\n\nI know an old lady who swallowed a cow.\nI don''t know how she swallowed a cow!\nShe swallowed the cow to catch the goat.\nShe swallowed the goat to catch the dog.\nShe swallowed the dog to catch the cat.\nShe swallowed the cat to catch the bird.\nShe swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.\nShe swallowed the spider to catch the fly.\nI don''t know why she swallowed the fly. Perhaps she''ll die.\n\nI know an old lady who swallowed a horse.\nShe''s dead, of course!'
  );

UPDATE tests
SET
  expected = REPLACE(expected, '\n', CHAR(10));

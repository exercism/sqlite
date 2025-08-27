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
    'c0b5a5e6-c89d-49b1-a6b2-9f523bff33f7',
    'first day a partridge in a pear tree',
    1,
    1,
    'On the first day of Christmas my true love gave to me: a Partridge in a Pear Tree.'
  ),
  (
    '1c64508a-df3d-420a-b8e1-fe408847854a',
    'second day two turtle doves',
    2,
    2,
    'On the second day of Christmas my true love gave to me: two Turtle Doves, and a Partridge in a Pear Tree.'
  ),
  (
    'a919e09c-75b2-4e64-bb23-de4a692060a8',
    'third day three french hens',
    3,
    3,
    'On the third day of Christmas my true love gave to me: three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.'
  ),
  (
    '9bed8631-ec60-4894-a3bb-4f0ec9fbe68d',
    'fourth day four calling birds',
    4,
    4,
    'On the fourth day of Christmas my true love gave to me: four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.'
  ),
  (
    'cf1024f0-73b6-4545-be57-e9cea565289a',
    'fifth day five gold rings',
    5,
    5,
    'On the fifth day of Christmas my true love gave to me: five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.'
  ),
  (
    '50bd3393-868a-4f24-a618-68df3d02ff04',
    'sixth day six geese-a-laying',
    6,
    6,
    'On the sixth day of Christmas my true love gave to me: six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.'
  ),
  (
    '8f29638c-9bf1-4680-94be-e8b84e4ade83',
    'seventh day seven swans-a-swimming',
    7,
    7,
    'On the seventh day of Christmas my true love gave to me: seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.'
  ),
  (
    '7038d6e1-e377-47ad-8c37-10670a05bc05',
    'eighth day eight maids-a-milking',
    8,
    8,
    'On the eighth day of Christmas my true love gave to me: eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.'
  ),
  (
    '37a800a6-7a56-4352-8d72-0f51eb37cfe8',
    'ninth day nine ladies dancing',
    9,
    9,
    'On the ninth day of Christmas my true love gave to me: nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.'
  ),
  (
    '10b158aa-49ff-4b2d-afc3-13af9133510d',
    'tenth day ten lords-a-leaping',
    10,
    10,
    'On the tenth day of Christmas my true love gave to me: ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.'
  ),
  (
    '08d7d453-f2ba-478d-8df0-d39ea6a4f457',
    'eleventh day eleven pipers piping',
    11,
    11,
    'On the eleventh day of Christmas my true love gave to me: eleven Pipers Piping, ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.'
  ),
  (
    '0620fea7-1704-4e48-b557-c05bf43967f0',
    'twelfth day twelve drummers drumming',
    12,
    12,
    'On the twelfth day of Christmas my true love gave to me: twelve Drummers Drumming, eleven Pipers Piping, ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.'
  ),
  (
    'da8b9013-b1e8-49df-b6ef-ddec0219e398',
    'recites first three verses of the song',
    1,
    3,
    'On the first day of Christmas my true love gave to me: a Partridge in a Pear Tree.\nOn the second day of Christmas my true love gave to me: two Turtle Doves, and a Partridge in a Pear Tree.\nOn the third day of Christmas my true love gave to me: three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.'
  ),
  (
    'c095af0d-3137-4653-ad32-bfb899eda24c',
    'recites three verses from the middle of the song',
    4,
    6,
    'On the fourth day of Christmas my true love gave to me: four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.\nOn the fifth day of Christmas my true love gave to me: five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.\nOn the sixth day of Christmas my true love gave to me: six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.'
  ),
  (
    '20921bc9-cc52-4627-80b3-198cbbfcf9b7',
    'recites the whole song',
    1,
    12,
    'On the first day of Christmas my true love gave to me: a Partridge in a Pear Tree.\nOn the second day of Christmas my true love gave to me: two Turtle Doves, and a Partridge in a Pear Tree.\nOn the third day of Christmas my true love gave to me: three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.\nOn the fourth day of Christmas my true love gave to me: four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.\nOn the fifth day of Christmas my true love gave to me: five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.\nOn the sixth day of Christmas my true love gave to me: six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.\nOn the seventh day of Christmas my true love gave to me: seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.\nOn the eighth day of Christmas my true love gave to me: eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.\nOn the ninth day of Christmas my true love gave to me: nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.\nOn the tenth day of Christmas my true love gave to me: ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.\nOn the eleventh day of Christmas my true love gave to me: eleven Pipers Piping, ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.\nOn the twelfth day of Christmas my true love gave to me: twelve Drummers Drumming, eleven Pipers Piping, ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.'
  );

UPDATE tests
SET
  expected = REPLACE(expected, '\n', CHAR(10));

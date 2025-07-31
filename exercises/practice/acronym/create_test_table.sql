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
  phrase    TEXT NOT NULL,
  expected TEXT NOT NULL
);

-- Note: the strings below _may_ contain literal tab, newline, or carriage returns.

INSERT INTO tests (uuid, description, phrase, expected)
VALUES
        ('1e22cceb-c5e4-4562-9afe-aef07ad1eaf4','basic','Portable Network Graphics','PNG'),
        ('79ae3889-a5c0-4b01-baf0-232d31180c08','lowercase words','Ruby on Rails','ROR'),
        ('ec7000a7-3931-4a17-890e-33ca2073a548','punctuation','First In, First Out','FIFO'),
        ('32dd261c-0c92-469a-9c5c-b192e94a63b0','all caps word','GNU Image Manipulation Program','GIMP'),
        ('ae2ac9fa-a606-4d05-8244-3bcc4659c1d4','punctuation without whitespace','Complementary metal-oxide semiconductor','CMOS'),
        ('0e4b1e7c-1a6d-48fb-81a7-bf65eb9e69f9','very long abbreviation','Rolling On The Floor Laughing So Hard That My Dogs Came Over And Licked Me','ROTFLSHTMDCOALM'),
        ('6a078f49-c68d-4b7b-89af-33a1a98c28cc','consecutive delimiters','Something - I made up from thin air','SIMUFTA'),
        ('5118b4b1-4572-434c-8d57-5b762e57973e','apostrophes','Halley''s Comet','HC'),
        ('adc12eab-ec2d-414f-b48c-66a4fc06cdef','underscore emphasis','The Road _Not_ Taken','TRNT');

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
  meeting_start TEXT NOT NULL, -- datetime YYYY-MM-DDTHH:mm:ss
  date_description TEXT NOT NULL,
  expected TEXT NOT NULL
);

INSERT INTO
  tests (
    uuid,
    description,
    meeting_start,
    date_description,
    expected
  )
VALUES
  (
    '1d0e6e72-f370-408c-bc64-5dafa9c6da73',
    'NOW translates to two hours later',
    '2012-02-13T09:00:00',
    'NOW',
    '2012-02-13T11:00:00'
  ),
  (
    '93325e7b-677d-4d96-b017-2582af879dc2',
    'ASAP before one in the afternoon translates to today at five in the afternoon',
    '1999-06-03T09:45:00',
    'ASAP',
    '1999-06-03T17:00:00'
  ),
  (
    'cb4252a3-c4c1-41f6-8b8c-e7269733cef8',
    'ASAP at one in the afternoon translates to tomorrow at one in the afternoon',
    '2008-12-21T13:00:00',
    'ASAP',
    '2008-12-22T13:00:00'
  ),
  (
    '6fddc1ea-2fe9-4c60-81f7-9220d2f45537',
    'ASAP after one in the afternoon translates to tomorrow at one in the afternoon',
    '2008-12-21T14:50:00',
    'ASAP',
    '2008-12-22T13:00:00'
  ),
  (
    '25f46bf9-6d2a-4e95-8edd-f62dd6bc8a6e',
    'EOW on Monday translates to Friday at five in the afternoon',
    '2025-02-03T16:00:00',
    'EOW',
    '2025-02-07T17:00:00'
  ),
  (
    '0b375df5-d198-489e-acee-fd538a768616',
    'EOW on Tuesday translates to Friday at five in the afternoon',
    '1997-04-29T10:50:00',
    'EOW',
    '1997-05-02T17:00:00'
  ),
  (
    '4afbb881-0b5c-46be-94e1-992cdc2a8ca4',
    'EOW on Wednesday translates to Friday at five in the afternoon',
    '2005-09-14T11:00:00',
    'EOW',
    '2005-09-16T17:00:00'
  ),
  (
    'e1341c2b-5e1b-4702-a95c-a01e8e96e510',
    'EOW on Thursday translates to Sunday at eight in the evening',
    '2011-05-19T08:30:00',
    'EOW',
    '2011-05-22T20:00:00'
  ),
  (
    'bbffccf7-97f7-4244-888d-bdd64348fa2e',
    'EOW on Friday translates to Sunday at eight in the evening',
    '2022-08-05T14:00:00',
    'EOW',
    '2022-08-07T20:00:00'
  ),
  (
    'd651fcf4-290e-407c-8107-36b9076f39b2',
    'EOW translates to leap day',
    '2008-02-25T10:30:00',
    'EOW',
    '2008-02-29T17:00:00'
  ),
  (
    '439bf09f-3a0e-44e7-bad5-b7b6d0c4505a',
    '2M before the second month of this year translates to the first workday of the second month of this year',
    '2007-01-02T14:15:00',
    '2M',
    '2007-02-01T08:00:00'
  ),
  (
    '86d82e83-c481-4fb4-9264-625de7521340',
    '11M in the eleventh month translates to the first workday of the eleventh month of next year',
    '2013-11-21T15:30:00',
    '11M',
    '2014-11-03T08:00:00'
  ),
  (
    '0d0b8f6a-1915-46f5-a630-1ff06af9da08',
    '4M in the ninth month translates to the first workday of the fourth month of next year',
    '2019-11-18T15:15:00',
    '4M',
    '2020-04-01T08:00:00'
  ),
  (
    '06d401e3-8461-438f-afae-8d26aa0289e0',
    'Q1 in the first quarter translates to the last workday of the first quarter of this year',
    '2003-01-01T10:45:00',
    'Q1',
    '2003-03-31T08:00:00'
  ),
  (
    'eebd5f32-b16d-4ecd-91a0-584b0364b7ed',
    'Q4 in the second quarter translates to the last workday of the fourth quarter of this year',
    '2001-04-09T09:00:00',
    'Q4',
    '2001-12-31T08:00:00'
  ),
  (
    'c920886c-44ad-4d34-a156-dc4176186581',
    'Q3 in the fourth quarter translates to the last workday of the third quarter of next year',
    '2022-10-06T11:00:00',
    'Q3',
    '2023-09-29T08:00:00'
  );

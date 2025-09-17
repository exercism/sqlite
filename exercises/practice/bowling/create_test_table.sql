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
  previous_rolls TEXT NOT NULL, -- json array
  roll INTEGER,
  expected_result TEXT,
  expected_error TEXT
);

INSERT INTO tests (uuid,
                   description,
                   property,
                   previous_rolls,
                   roll,
                   expected_result,
                   expected_error)
VALUES
('656ae006-25c2-438c-a549-f338e7ec7441', 'should be able to score a game with all zeros', 'score', '[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]', NULL, 0, NULL),
('f85dcc56-cd6b-4875-81b3-e50921e3597b', 'should be able to score a game with no strikes or spares', 'score', '[3,6,3,6,3,6,3,6,3,6,3,6,3,6,3,6,3,6,3,6]', NULL, 90, NULL),
('d1f56305-3ac2-4fe0-8645-0b37e3073e20', 'a spare followed by zeros is worth ten points', 'score', '[6,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]', NULL, 10, NULL),
('0b8c8bb7-764a-4287-801a-f9e9012f8be4', 'points scored in the roll after a spare are counted twice', 'score', '[6,4,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]', NULL, 16, NULL),
('4d54d502-1565-4691-84cd-f29a09c65bea', 'consecutive spares each get a one roll bonus', 'score', '[5,5,3,7,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]', NULL, 31, NULL),
('e5c9cf3d-abbe-4b74-ad48-34051b2b08c0', 'a spare in the last frame gets a one roll bonus that is counted once', 'score', '[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,3,7]', NULL, 17, NULL),
('75269642-2b34-4b72-95a4-9be28ab16902', 'a strike earns ten points in a frame with a single roll', 'score', '[10,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]', NULL, 10, NULL),
('037f978c-5d01-4e49-bdeb-9e20a2e6f9a6', 'points scored in the two rolls after a strike are counted twice as a bonus', 'score', '[10,5,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]', NULL, 26, NULL),
('1635e82b-14ec-4cd1-bce4-4ea14bd13a49', 'consecutive strikes each get the two roll bonus', 'score', '[10,10,10,5,3,0,0,0,0,0,0,0,0,0,0,0,0]', NULL, 81, NULL),
('e483e8b6-cb4b-4959-b310-e3982030d766', 'a strike in the last frame gets a two roll bonus that is counted once', 'score', '[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,10,7,1]', NULL, 18, NULL),
('9d5c87db-84bc-4e01-8e95-53350c8af1f8', 'rolling a spare with the two roll bonus does not get a bonus roll', 'score', '[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,10,7,3]', NULL, 20, NULL),
('576faac1-7cff-4029-ad72-c16bcada79b5', 'strikes with the two roll bonus do not get bonus rolls', 'score', '[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,10,10,10]', NULL, 30, NULL),
('efb426ec-7e15-42e6-9b96-b4fca3ec2359', 'last two strikes followed by only last bonus with non strike points', 'score', '[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,10,10,0,1]', NULL, 31, NULL),
('72e24404-b6c6-46af-b188-875514c0377b', 'a strike with the one roll bonus after a spare in the last frame does not get a bonus', 'score', '[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,3,10]', NULL, 20, NULL),
('62ee4c72-8ee8-4250-b794-234f1fec17b1', 'all strikes is a perfect game', 'score', '[10,10,10,10,10,10,10,10,10,10,10,10]', NULL, 300, NULL),
('1245216b-19c6-422c-b34b-6e4012d7459f', 'rolls cannot score negative points', 'roll', '[]', -1, NULL, 'Negative roll is invalid'),
('5fcbd206-782c-4faa-8f3a-be5c538ba841', 'a roll cannot score more than 10 points', 'roll', '[]', 11, NULL, 'Pin count exceeds pins on the lane'),
('fb023c31-d842-422d-ad7e-79ce1db23c21', 'two rolls in a frame cannot score more than 10 points', 'roll', '[5]', 6, NULL, 'Pin count exceeds pins on the lane'),
('6082d689-d677-4214-80d7-99940189381b', 'bonus roll after a strike in the last frame cannot score more than 10 points', 'roll', '[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,10]', 11, NULL, 'Pin count exceeds pins on the lane'),
('e9565fe6-510a-4675-ba6b-733a56767a45', 'two bonus rolls after a strike in the last frame cannot score more than 10 points', 'roll', '[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,10,5]', 6, NULL, 'Pin count exceeds pins on the lane'),
('2f6acf99-448e-4282-8103-0b9c7df99c3d', 'two bonus rolls after a strike in the last frame can score more than 10 points if one is a strike', 'score', '[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,10,10,6]', NULL, 26, NULL),
('6380495a-8bc4-4cdb-a59f-5f0212dbed01', 'the second bonus rolls after a strike in the last frame cannot be a strike if the first one is not a strike', 'roll', '[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,10,6]', 10, NULL, 'Pin count exceeds pins on the lane'),
('2b2976ea-446c-47a3-9817-42777f09fe7e', 'second bonus roll after a strike in the last frame cannot score more than 10 points', 'roll', '[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,10,10]', 11, NULL, 'Pin count exceeds pins on the lane'),
('29220245-ac8d-463d-bc19-98a94cfada8a', 'an unstarted game cannot be scored', 'score', '[]', NULL, NULL, 'Score cannot be taken until the end of the game'),
('4473dc5d-1f86-486f-bf79-426a52ddc955', 'an incomplete game cannot be scored', 'score', '[0,0]', NULL, NULL, 'Score cannot be taken until the end of the game'),
('2ccb8980-1b37-4988-b7d1-e5701c317df3', 'cannot roll if game already has ten frames', 'roll', '[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]', 0, NULL, 'Cannot roll after game is over'),
('4864f09b-9df3-4b65-9924-c595ed236f1b', 'bonus rolls for a strike in the last frame must be rolled before score can be calculated', 'score', '[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,10]', NULL, NULL, 'Score cannot be taken until the end of the game'),
('537f4e37-4b51-4d1c-97e2-986eb37b2ac1', 'both bonus rolls for a strike in the last frame must be rolled before score can be calculated', 'score', '[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,10,10]', NULL, NULL, 'Score cannot be taken until the end of the game'),
('8134e8c1-4201-4197-bf9f-1431afcde4b9', 'bonus roll for a spare in the last frame must be rolled before score can be calculated', 'score', '[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,3]', NULL, NULL, 'Score cannot be taken until the end of the game'),
('9d4a9a55-134a-4bad-bae8-3babf84bd570', 'cannot roll after bonus roll for spare', 'roll', '[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,3,2]', 2, NULL, 'Cannot roll after game is over'),
('d3e02652-a799-4ae3-b53b-68582cc604be', 'cannot roll after bonus rolls for strike', 'roll', '[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,10,3,2]', 2, NULL, 'Cannot roll after game is over');

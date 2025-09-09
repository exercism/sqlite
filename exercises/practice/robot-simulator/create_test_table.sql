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
  input INTEGER NOT NULL, -- json object
  expected TEXT NOT NULL -- json object
);

INSERT INTO
  tests (uuid, description, property, input, expected)
VALUES
  (
    'c557c16d-26c1-4e06-827c-f6602cd0785c',
    'at origin facing north',
    'create',
    '{"position":{"x":0,"y":0},"direction":"north"}',
    '{"position":{"x":0,"y":0},"direction":"north"}'
  ),
  (
    'bf0dffce-f11c-4cdb-8a5e-2c89d8a5a67d',
    'at negative position facing south',
    'create',
    '{"position":{"x":-1,"y":-1},"direction":"south"}',
    '{"position":{"x":-1,"y":-1},"direction":"south"}'
  ),
  (
    '8cbd0086-6392-4680-b9b9-73cf491e67e5',
    'changes north to east',
    'move',
    '{"position":{"x":0,"y":0},"direction":"north","instructions":"R"}',
    '{"position":{"x":0,"y":0},"direction":"east"}'
  ),
  (
    '8abc87fc-eab2-4276-93b7-9c009e866ba1',
    'changes east to south',
    'move',
    '{"position":{"x":0,"y":0},"direction":"east","instructions":"R"}',
    '{"position":{"x":0,"y":0},"direction":"south"}'
  ),
  (
    '3cfe1b85-bbf2-4bae-b54d-d73e7e93617a',
    'changes south to west',
    'move',
    '{"position":{"x":0,"y":0},"direction":"south","instructions":"R"}',
    '{"position":{"x":0,"y":0},"direction":"west"}'
  ),
  (
    '5ea9fb99-3f2c-47bd-86f7-46b7d8c3c716',
    'changes west to north',
    'move',
    '{"position":{"x":0,"y":0},"direction":"west","instructions":"R"}',
    '{"position":{"x":0,"y":0},"direction":"north"}'
  ),
  (
    'fa0c40f5-6ba3-443d-a4b3-58cbd6cb8d63',
    'changes north to west',
    'move',
    '{"position":{"x":0,"y":0},"direction":"north","instructions":"L"}',
    '{"position":{"x":0,"y":0},"direction":"west"}'
  ),
  (
    'da33d734-831f-445c-9907-d66d7d2a92e2',
    'changes west to south',
    'move',
    '{"position":{"x":0,"y":0},"direction":"west","instructions":"L"}',
    '{"position":{"x":0,"y":0},"direction":"south"}'
  ),
  (
    'bd1ca4b9-4548-45f4-b32e-900fc7c19389',
    'changes south to east',
    'move',
    '{"position":{"x":0,"y":0},"direction":"south","instructions":"L"}',
    '{"position":{"x":0,"y":0},"direction":"east"}'
  ),
  (
    '2de27b67-a25c-4b59-9883-bc03b1b55bba',
    'changes east to north',
    'move',
    '{"position":{"x":0,"y":0},"direction":"east","instructions":"L"}',
    '{"position":{"x":0,"y":0},"direction":"north"}'
  ),
  (
    'f0dc2388-cddc-4f83-9bed-bcf46b8fc7b8',
    'facing north increments Y',
    'move',
    '{"position":{"x":0,"y":0},"direction":"north","instructions":"A"}',
    '{"position":{"x":0,"y":1},"direction":"north"}'
  ),
  (
    '2786cf80-5bbf-44b0-9503-a89a9c5789da',
    'facing south decrements Y',
    'move',
    '{"position":{"x":0,"y":0},"direction":"south","instructions":"A"}',
    '{"position":{"x":0,"y":-1},"direction":"south"}'
  ),
  (
    '84bf3c8c-241f-434d-883d-69817dbd6a48',
    'facing east increments X',
    'move',
    '{"position":{"x":0,"y":0},"direction":"east","instructions":"A"}',
    '{"position":{"x":1,"y":0},"direction":"east"}'
  ),
  (
    'bb69c4a7-3bbf-4f64-b415-666fa72d7b04',
    'facing west decrements X',
    'move',
    '{"position":{"x":0,"y":0},"direction":"west","instructions":"A"}',
    '{"position":{"x":-1,"y":0},"direction":"west"}'
  ),
  (
    'e34ac672-4ed4-4be3-a0b8-d9af259cbaa1',
    'moving east and north from README',
    'move',
    '{"position":{"x":7,"y":3},"direction":"north","instructions":"RAALAL"}',
    '{"position":{"x":9,"y":4},"direction":"west"}'
  ),
  (
    'f30e4955-4b47-4aa3-8b39-ae98cfbd515b',
    'moving west and north',
    'move',
    '{"position":{"x":0,"y":0},"direction":"north","instructions":"LAAARALA"}',
    '{"position":{"x":-4,"y":1},"direction":"west"}'
  ),
  (
    '3e466bf6-20ab-4d79-8b51-264165182fca',
    'moving west and south',
    'move',
    '{"position":{"x":2,"y":-7},"direction":"east","instructions":"RRAAAAALA"}',
    '{"position":{"x":-3,"y":-8},"direction":"south"}'
  ),
  (
    '41f0bb96-c617-4e6b-acff-a4b279d44514',
    'moving east and north',
    'move',
    '{"position":{"x":8,"y":4},"direction":"south","instructions":"LAAARRRALLLL"}',
    '{"position":{"x":11,"y":5},"direction":"north"}'
  );

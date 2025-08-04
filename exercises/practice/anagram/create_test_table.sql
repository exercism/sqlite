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
    subject    TEXT NOT NULL,
    candidates TEXT NOT NULL,   -- json array of strings
    expected   TEXT NOT NULL
);

INSERT INTO tests (uuid, description, subject, candidates, expected)
    VALUES
        ('dd40c4d2-3c8b-44e5-992a-f42b393ec373','no matches','diaper','["hello","world","zombies","pants"]','[]'),
        ('03eb9bbe-8906-4ea0-84fa-ffe711b52c8b','detects two anagrams','solemn','["lemons","cherry","melons"]','["lemons","melons"]'),
        ('a27558ee-9ba0-4552-96b1-ecf665b06556','does not detect anagram subsets','good','["dog","goody"]','[]'),
        ('64cd4584-fc15-4781-b633-3d814c4941a4','detects anagram','listen','["enlists","google","inlets","banana"]','["inlets"]'),
        ('99c91beb-838f-4ccd-b123-935139917283','detects three anagrams','allergy','["gallery","ballerina","regally","clergy","largely","leading"]','["gallery","regally","largely"]'),
        ('78487770-e258-4e1f-a646-8ece10950d90','detects multiple anagrams with different case','nose','["Eons","ONES"]','["Eons","ONES"]'),
        ('1d0ab8aa-362f-49b7-9902-3d0c668d557b','does not detect non-anagrams with identical checksum','mass','["last"]','[]'),
        ('9e632c0b-c0b1-4804-8cc1-e295dea6d8a8','detects anagrams case-insensitively','Orchestra','["cashregister","Carthorse","radishes"]','["Carthorse"]'),
        ('b248e49f-0905-48d2-9c8d-bd02d8c3e392','detects anagrams using case-insensitive subject','Orchestra','["cashregister","carthorse","radishes"]','["carthorse"]'),
        ('f367325c-78ec-411c-be76-e79047f4bd54','detects anagrams using case-insensitive possible matches','orchestra','["cashregister","Carthorse","radishes"]','["Carthorse"]'),
        ('630abb71-a94e-4715-8395-179ec1df9f91','does not detect an anagram if the original word is repeated','go','["goGoGO"]','[]'),
        ('9878a1c9-d6ea-4235-ae51-3ea2befd6842','anagrams must use all letters exactly once','tapper','["patter"]','[]'),
        ('68934ed0-010b-4ef9-857a-20c9012d1ebf','words are not anagrams of themselves','BANANA','["BANANA"]','[]'),
        ('589384f3-4c8a-4e7d-9edc-51c3e5f0c90e','words are not anagrams of themselves even if letter case is partially different','BANANA','["Banana"]','[]'),
        ('ba53e423-7e02-41ee-9ae2-71f91e6d18e6','words are not anagrams of themselves even if letter case is completely different','BANANA','["banana"]','[]'),
        ('33d3f67e-fbb9-49d3-a90e-0beb00861da7','words other than themselves can be anagrams','LISTEN','["LISTEN","Silent"]','["Silent"]');

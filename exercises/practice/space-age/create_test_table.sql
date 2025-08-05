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
    planet   TEXT    NOT NULL,
    seconds  INTEGER NOT NULL,
    expected TEXT    NOT NULL   -- json object
);

INSERT INTO tests (uuid, description, planet, seconds, expected)
    VALUES
        ('84f609af-5a91-4d68-90a3-9e32d8a5cd34','age on Earth','Earth',1000000000,'{"age":31.69}'),
        ('ca20c4e9-6054-458c-9312-79679ffab40b','age on Mercury','Mercury',2134835688,'{"age":280.88}'),
        ('502c6529-fd1b-41d3-8fab-65e03082b024','age on Venus','Venus',189839836,'{"age":9.78}'),
        ('9ceadf5e-a0d5-4388-9d40-2c459227ceb8','age on Mars','Mars',2129871239,'{"age":35.88}'),
        ('42927dc3-fe5e-4f76-a5b5-f737fc19bcde','age on Jupiter','Jupiter',901876382,'{"age":2.41}'),
        ('8469b332-7837-4ada-b27c-00ee043ebcad','age on Saturn','Saturn',2000000000,'{"age":2.15}'),
        ('999354c1-76f8-4bb5-a672-f317b6436743','age on Uranus','Uranus',1210123456,'{"age":0.46}'),
        ('80096d30-a0d4-4449-903e-a381178355d8','age on Neptune','Neptune',1821023456,'{"age":0.35}'),
        ('57b96e2a-1178-40b7-b34d-f3c9c34e4bf4','invalid planet causes error','Sun',680804807,'{"error":"not a planet"}');

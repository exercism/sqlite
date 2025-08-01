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
  input_base  INTEGER NOT NULL,
  digits      TEXT    NOT NULL,
  output_base INTEGER NOT NULL,
  expected    TEXT
);

INSERT INTO tests (uuid, description, input_base, digits, output_base, expected)
VALUES
        ('5ce422f9-7a4b-4f44-ad29-49c67cb32d2c','single bit one to decimal',2,'[1]',10,'[1]'),
        ('0cc3fea8-bb79-46ac-a2ab-5a2c93051033','binary to single decimal',2,'[1,0,1]',10,'[5]'),
        ('f12db0f9-0d3d-42c2-b3ba-e38cb375a2b8','single decimal to binary',10,'[5]',2,'[1,0,1]'),
        ('2c45cf54-6da3-4748-9733-5a3c765d925b','binary to multiple decimal',2,'[1,0,1,0,1,0]',10,'[4,2]'),
        ('65ddb8b4-8899-4fcc-8618-181b2cf0002d','decimal to binary',10,'[4,2]',2,'[1,0,1,0,1,0]'),
        ('8d418419-02a7-4824-8b7a-352d33c6987e','trinary to hexadecimal',3,'[1,1,2,0]',16,'[2,10]'),
        ('d3901c80-8190-41b9-bd86-38d988efa956','hexadecimal to trinary',16,'[2,10]',3,'[1,1,2,0]'),
        ('5d42f85e-21ad-41bd-b9be-a3e8e4258bbf','15-bit integer',97,'[3,46,60]',73,'[6,10,45]'),
        ('d68788f7-66dd-43f8-a543-f15b6d233f83','empty list',2,'[]',10,'[0]'),
        ('5e27e8da-5862-4c5f-b2a9-26c0382b6be7','single zero',10,'[0]',2,'[0]'),
        ('2e1c2573-77e4-4b9c-8517-6c56c5bcfdf2','multiple zeros',10,'[0,0,0]',2,'[0]'),
        ('3530cd9f-8d6d-43f5-bc6e-b30b1db9629b','leading zeros',7,'[0,6,0]',10,'[4,2]'),
        ('a6b476a1-1901-4f2a-92c4-4d91917ae023','input base is one',1,'[0]',10,'{"error":"input base must be >= 2"}'),
        ('e21a693a-7a69-450b-b393-27415c26a016','input base is zero',0,'[]',10,'{"error":"input base must be >= 2"}'),
        ('54a23be5-d99e-41cc-88e0-a650ffe5fcc2','input base is negative',-2,'[1]',10,'{"error":"input base must be >= 2"}'),
        ('9eccf60c-dcc9-407b-95d8-c37b8be56bb6','negative digit',2,'[1,-1,1,0,1,0]',10,'{"error":"all digits must satisfy 0 <= d < input base"}'),
        ('232fa4a5-e761-4939-ba0c-ed046cd0676a','invalid positive digit',2,'[1,2,1,0,1,0]',10,'{"error":"all digits must satisfy 0 <= d < input base"}'),
        ('14238f95-45da-41dc-95ce-18f860b30ad3','output base is one',2,'[1,0,1,0,1,0]',1,'{"error":"output base must be >= 2"}'),
        ('73dac367-da5c-4a37-95fe-c87fad0a4047','output base is zero',10,'[7]',0,'{"error":"output base must be >= 2"}'),
        ('13f81f42-ff53-4e24-89d9-37603a48ebd9','output base is negative',2,'[1]',-7,'{"error":"output base must be >= 2"}'),
        ('0e6c895d-8a5d-4868-a345-309d094cfe8d','both bases are negative',-2,'[1]',-7,'{"error":"input base must be >= 2"}');


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
    input INT NOT NULL,
    expected INT NOT NULL
);

INSERT INTO tests (uuid, description, input, expected)
VALUES
    (
        'a0e97d2d-669e-47c7-8134-518a1e2c4555',
        'empty string',
        '',
        1
    ),
    (
        '9a001b50-f194-4143-bc29-2af5ec1ef652',
        'isogram with only lower case characters',
        'isogram',
        1
    ),
    (
        '8ddb0ca3-276e-4f8b-89da-d95d5bae78a4',
        'word with one duplicated character',
        'eleven',
        0
    ),
    (
        '6450b333-cbc2-4b24-a723-0b459b34fe18',
        'word with one duplicated character from the end of the alphabet',
        'zzyzx',
        0
    ),
    (
        'a15ff557-dd04-4764-99e7-02cc1a385863',
        'longest reported english isogram',
        'subdermatoglyphic',
        1
    ),
    (
        'f1a7f6c7-a42f-4915-91d7-35b2ea11c92e',
        'word with duplicated character in mixed case',
        'Alphabet',
        0
    ),
    (
        '14a4f3c1-3b47-4695-b645-53d328298942',
        'word with duplicated character in mixed case, lowercase first',
        'alphAbet',
        0
    ),
    (
        '423b850c-7090-4a8a-b057-97f1cadd7c42',
        'hypothetical isogrammic word with hyphen',
        'thumbscrew-japingly',
        1
    ),
    (
        '93dbeaa0-3c5a-45c2-8b25-428b8eacd4f2',
        'hypothetical word with duplicated character following hyphen',
        'thumbscrew-jappingly',
        0
    ),
    (
        '36b30e5c-173f-49c6-a515-93a3e825553f',
        'isogram with duplicated hyphen',
        'six-year-old',
        1
    ),
    (
        'cdabafa0-c9f4-4c1f-b142-689c6ee17d93',
        'made-up name that is an isogram',
        'Emily Jung Schwartzkopf',
        1
    ),
    (
        '5fc61048-d74e-48fd-bc34-abfc21552d4d',
        'duplicated character in the middle',
        'accentor',
        0
    ),
    (
        '310ac53d-8932-47bc-bbb4-b2b94f25a83e',
        'same first and last characters',
        'angola',
        0
    ),
    (
        '0d0b8644-0a1e-4a31-a432-2b3ee270d847',
        'word with duplicated character and with two hyphens',
        'up-to-date',
        0
    );

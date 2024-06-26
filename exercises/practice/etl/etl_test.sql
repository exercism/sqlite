-- Setup test table and read in student solution:
.read ./test_setup.sql

-- Test cases:
INSERT INTO tests (name, uuid,
                    input, expected)
    VALUES
        ('single letter', '78a7a9f9-4490-4a47-8ee9-5a38bb47d28f',
            '{"1":["A"]}',
            '{"a":1}'),
        ('single score with multiple letters', '60dbd000-451d-44c7-bdbb-97c73ac1f497',
            '{"1":["A","E","I","O","U"]}',
            '{"a":1,"e":1,"i":1,"o":1,"u":1}'),
        ('multiple scores with multiple letters', 'f5c5de0c-301f-4fdd-a0e5-df97d4214f54',
            '{"1":["A","E"],"2":["D","G"]}',
            '{"a":1,"d":2,"e":1,"g":2}'),
        ('multiple scores with differing numbers of letters', '5db8ea89-ecb4-4dcd-902f-2b418cc87b9d',
            '{"1":["A","E","I","O","U","L","N","R","S","T"],"2":["D","G"],"3":["B","C","M","P"],"4":["F","H","V","W","Y"],"5":["K"],"8":["J","X"],"10":["Q","Z"]}',
            '{"a":1,"b":3,"c":3,"d":2,"e":1,"f":4,"g":2,"h":4,"i":1,"j":8,"k":5,"l":1,"m":3,"n":1,"o":1,"p":3,"q":10,"r":1,"s":1,"t":1,"u":1,"v":4,"w":4,"x":8,"y":4,"z":10}');


-- Comparison of user input and the tests updates the status for each test:
UPDATE tests
SET status = 'pass'
FROM (SELECT input, result FROM "etl") AS actual
WHERE (actual.input, json(actual.result)) = (tests.input, json(tests.expected));

-- Write results and debug info:
.read ./test_reporter.sql

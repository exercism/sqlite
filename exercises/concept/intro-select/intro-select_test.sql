-- Create database:
.read ./create_fixture.sql

.mode columns

-- Generate expected output
.output expected_output.txt
.read ./intro-select_exemplar.sql

-- Run user solution
.output user_output.txt
.read ./intro-select.sql

-- Compare expected vs actual
.shell diff expected_output.txt user_output.txt


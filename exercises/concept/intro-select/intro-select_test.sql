-- Create database:
.read ./create_fixture.sql

.mode json

-- Run user solution
.output user_output.txt
.read ./intro-select.sql

-- Compare expected vs actual
.shell python evaluate.py test_data.json user_output.txt

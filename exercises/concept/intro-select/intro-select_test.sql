-- Create database:
.read ./create_fixture.sql

.mode columns

-- Generate expected output
.output expected_output.txt

.print
.print "All data"
.print "========"
.print
.read intro-select-task1_exemplar.sql

.print 
.print "Location and temperature only"
.print "============================="
.print
.read intro-select-task2_exemplar.sql

.print 
.print "Greeting"
.print "========"
.print
.read intro-select-task3_exemplar.sql

.print 
.print "Data for Seattle"
.print "================"
.print
.read intro-select-task4_exemplar.sql

.print 
.print "Data with humidity constraints"
.print "=============================="
.print
.read intro-select-task5_exemplar.sql

.print 
.print "Locations"
.print "========="
.print
.read intro-select-task6_exemplar.sql


-- Run user solutions
.output user_output.txt
.print
.print "All data"
.print "========"
.print
.read intro-select-task1.sql

.print 
.print "Location and temperature only"
.print "============================="
.print
.read intro-select-task2.sql

.print 
.print "Greeting"
.print "========"
.print
.read intro-select-task3.sql

.print 
.print "Data for Seattle"
.print "================"
.print
.read intro-select-task4.sql

.print 
.print "Data with humidity constraints"
.print "=============================="
.print
.read intro-select-task5.sql

.print 
.print "Locations"
.print "========="
.print
.read intro-select-task6.sql


-- Compare expected vs actual
.shell diff expected_output.txt user_output.txt


.print
.print "All data"
.print "========"
.print
SELECT * FROM weather_readings;

.print 
.print "Location and temperature only"
.print "============================="
.print
SELECT location, temperature FROM weather_readings;

.print 
.print "Greeting"
.print "========"
.print
SELECT 'Hello, world.';

.print 
.print "Data for Seattle"
.print "================"
.print
SELECT * FROM weather_readings WHERE location = 'Seattle';

.print 
.print "Data with humidity constraints"
.print "=============================="
.print
SELECT * FROM weather_readings WHERE humidity BETWEEN 60 AND 70;

.print 
.print "Locations"
.print "========="
.print
SELECT location FROM weather_readings;

.print 
.print "Unique locations"
.print "================"
.print
SELECT DISTINCT location FROM weather_readings;

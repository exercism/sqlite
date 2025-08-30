UPDATE gigasecond
SET
  result = date(moment, '+1000000000 seconds') || 'T' || time(moment, '+1000000000 seconds');

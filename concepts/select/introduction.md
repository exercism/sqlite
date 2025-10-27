# The SELECT statement

In SQL, a `SELECT` statement allows you to retrieve data from a database.
The result of a `SELECT` statement is a result set -- some number of values arranged in rows and columns, where each column is a particular attribute of the data and each row is a set of values for each column.

Roughly, you can think of the set of columns as a data structure, where each column represents a field of the data structure, and each row represents a concrete instance of the data structure.

With a `SELECT` statement, you can specify the data you want and optionally transform, filter, and/or modify the shape of the output data.


## The basics

The anatomy of a basic `SELECT` statement is as follows:

```sql
SELECT <columns>
FROM <source>
WHERE <criteria>;
```

Note that the line breaks are not required; any spacing will suffice to separate the different
clauses (i.e. parts) of the `SELECT` statement.

Immediately following the `SELECT` keyword is a list of the columns that you want in the result.
The `FROM` clause identifies the source of the data, which is typically a table in the database.
The `WHERE` clause filters the output data by one or more criteria.

For example, consider a database with a table named `weather_readings` containing the following data:


| date       | location     | temperature | humidity |
|------------|--------------|-------------|----------|
| 2025-10-22 | Portland     | 53.1        | 72       |
| 2025-10-22 | Seattle      | 56.2        | 66       |
| 2025-10-22 | Boise        | 60.4        | 55       |
| 2025-10-23 | Portland     | 54.6        | 70       |
| 2025-10-23 | Seattle      | 57.8        | 68       |
| 2025-10-23 | Boise        | 62.0        | 58       |


If we want to simply retrieve all of the data from the table, we could run the following query:

```sql
SELECT * FROM weather_readings;
```

Result:

```
date        location  temperature  humidity
----------  --------  -----------  --------
2025-10-22  Portland  53.1         72      
2025-10-22  Seattle   56.2         66      
2025-10-22  Boise     60.4         55      
2025-10-23  Portland  54.6         70      
2025-10-23  Seattle   57.8         68      
2025-10-23  Boise     62.0         58   
```

But if we only want the location and temperature values, we could specify those columns:

```sql
SELECT location, temperature FROM weather_readings;
```

Result:

```
location  temperature
--------  -----------
Portland  53.1          
Seattle   56.2          
Boise     60.4          
Portland  54.6          
Seattle   57.8          
Boise     62.0       
```

~~~~exercism/note
The `FROM` clause is optional.
A statement like `SELECT "Hello, world.";` is perfectly valid, and will generate the following result:

```
"Hello, world."
---------------
Hello, world. 
```
~~~~

## Filtering data with the WHERE clause

The `WHERE` clause allows you to filter the data retrieved by a `SELECT` statement.
For example, if we only want weather data for Seattle:

```sql
SELECT * FROM weather_readings
WHERE location = "Seattle";
```

Result:
```
date        location  temperature  humidity
----------  --------  -----------  --------
2025-10-22  Seattle   56.2         66      
2025-10-23  Seattle   57.8         68      
```


Or maybe we only want data where the humidity is between 60 and 70:

```sql
SELECT * FROM weather_readings
WHERE humidity BETWEEN 60 AND 70;
```


Result:
```
date        location  temperature  humidity
----------  --------  -----------  --------
2025-10-22  Seattle   56.2         66   
2025-10-23  Seattle   57.8         68      
2025-10-23  Portland  54.6         70      
```


In addition to `=` and `BETWEEN...AND`, the `WHERE` clause supports a wide range of expressions, including comparison (`<`, `<=`, `>`, `>=`), pattern matching (`LIKE`, `GLOB`, `REGEXP`, `MATCH`), and checking for membership in a list (`IN`, `NOT IN`).
See [SQL Language Expressions](sql-expr) for the complete documentation.


[sql-expr]: https://sqlite.org/lang_expr.html

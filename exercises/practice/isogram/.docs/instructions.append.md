# Additional instructions

You will be provided a table named "isogram".
The first column, "phrase", contains some text.
You need to determine if the phrase is an isogram.
Update the second column, "is_isogram", with an integer value:

* 1 if the phrase is an isogram,
* 0 if it is not.

~~~~exercism/note
SQLite comparison operations return boolean values as 0/1 numbers

```sh
$ sqlite3
sqlite> .mode table
sqlite> SELECT 1 < 2 AS "true", 1 > 2 AS "false";
+------+-------+
| true | false |
+------+-------+
| 1    | 0     |
+------+-------+
```
~~~~

# SQLite-specific instructions

* The **result** column should contain JSON-encoded data: an object
  with the age as double or a description of any errors.

Examples:
```
sqlite> SELECT JSON_OBJECT('age', 31.69);
{"age":31.69}
```
or
```
sqlite> SELECT JSON_OBJECT('error', 'some error description');
{"error":"some error description"}
```

## Table Schema

```sql
CREATE TABLE "space-age" (
    planet  TEXT    NOT NULL,
    seconds INTEGER NOT NULL,
    result  TEXT                -- json object
);

```

## JSON documentation

[JSON Functions And Operators][json-docs]

[json-docs]: https://www.sqlite.org/json1.html

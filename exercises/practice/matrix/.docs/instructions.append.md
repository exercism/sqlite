# SQLite-specific instructions

The **result** column contains a JSON-encoded list of integers.

Example:
```json
[9,8,7]
```

## Table Schema

```sql
CREATE TABLE matrix (
    property TEXT    NOT NULL,
    string   TEXT    NOT NULL,
    "index"  INTEGER NOT NULL,
    result   TEXT               -- json array of integers
);
```

## JSON documentation

[JSON Functions And Operators][json-docs]

[json-docs]: https://www.sqlite.org/json1.html

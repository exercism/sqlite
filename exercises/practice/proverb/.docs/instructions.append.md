# SQLite-specific instructions

The **strings** column contains a JSON-encoded list of strings.

Example:
```json
["nail", "shoe", "horse", "rider", "message", "battle", "kingdom"]
```

## Table Schema

```sql
CREATE TABLE proverb (
    strings TEXT NOT NULL,    -- json array
    result  TEXT
);
```

## JSON documentation

[JSON Functions And Operators][json-docs]

[json-docs]: https://www.sqlite.org/json1.html

# SQLite-specific instructions

The **list_one** and **list_two** columns contains JSON-enconded list of integers.

Example:

```json
[1, 2, 3]
```

## Table Schema

```sql
CREATE TABLE sublist (
    list_one TEXT NOT NULL,     -- json array
    list_two TEXT NOT NULL,     -- json array
    result   TEXT
);
```

## JSON documentation

[JSON Functions And Operators][json-docs]

[json-docs]: https://www.sqlite.org/json1.htmL

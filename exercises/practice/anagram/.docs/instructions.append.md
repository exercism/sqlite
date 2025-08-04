# SQLite-specific instructions

* The **candidates** column contains a JSON-encoded list of strings.
  Example:
  ```json
  ["stone","tones","banana","tons","notes","Seton"]
  ```
* The **result** column should contain JSON-encoded list of strings as well.

## Table Schema

```sql
CREATE TABLE anagram (
  subject    TEXT NOT NULL,
  candidates TEXT NOT NULL,     -- json array of strings
  result     TEXT               -- json array of strings
);
```

## JSON documentation

[JSON Functions And Operators][json-docs]

[json-docs]: https://www.sqlite.org/json1.htm

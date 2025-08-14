# SQLite-specific instructions

The **result** column should contain JSON-encoded object of objects, each word as key and count as integer.

For example, consider the sentence above: `"That's the password: 'PASSWORD 123'!", cried the Special Agent.\nSo I fled.`
The **result** for this input should be:

```json
{"123":1,"agent":1,"cried":1,"fled":1,"i":1,"password":2,"so":1,"special":1,"that's":1,"the":2}
```

## Table Schema

```sql
CREATE TABLE "word-count" (
    sentence TEXT NOT NULL,
    result   TEXT               -- json object
);
```

## JSON documentation

[JSON Functions And Operators][json-docs]

[json-docs]: https://www.sqlite.org/json1.html

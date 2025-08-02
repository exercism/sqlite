# SQLite-specific instructions

* The **digits** column contains a JSON-encoded list of integers.
  Example:
  ```json
  [1, 0, 1, 0, 1, 0]
  ```
* The **result** column should contain JSON-encoded data: an object with the digits as integers or a descripition of any errors.
  Examples:
  ```json
  {"digits":[1,0,1,0,1,0]}
  ```
  or
  ```json
  {"error":"some error description"}
  ```

## Table Schema

```sql
CREATE TABLE IF NOT EXISTS "all-your-base" (
  input_base  INTEGER NOT NULL,
  digits      TEXT    NOT NULL, -- json array
  output_base INTEGER NOT NULL,
  result      TEXT              -- json object
);
```

## JSON documentation

[ JSON Functions And Operators ](https://www.sqlite.org/json1.html)

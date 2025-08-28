# SQLite-specific instructions

- The **matrix** column contains the input, a JSON-encoded array of arrays of integers.
- The **result** columns should contain the output, the list of saddle points.
  The output should be a JSON-encoded array of objects, each object has two keys: row and column.
  For example, `[{"row": 2, "column": 1}]`.

## JSON documentation

See [JSON Functions And Operators][json-docs] for SQLite JSON functions.

[json-docs]: https://www.sqlite.org/json1.html

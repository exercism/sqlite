# Tests

Navigate to the directory containing the appropriate `${slug}_test.sql` file, where `${slug}` is the name of the exercise, using hyphens instead of spaces and all lowercase (e.g. `hello-world_test.sql` for the `Hello World` exercise).

```bash
sqlite3 -bail < ${slug}_test.sql
```

You can use `SELECT` statements for debugging.
The output will be forwarded to `user_output.md` and shown in the web-editor if tests fail.

You can find more information in the [sqlite track docs about testing](https://exercism.org/docs/tracks/sqlite/tests).

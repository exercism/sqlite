# Tests

Navigate to the directory containing the appropriate `${slug}-test.sql` file, where `${slug}` is the name of the exercise, using hyphens instead of spaces and all lowercase (e.g. `hello-world-test.sql` for the `Hello World` exercise).

```bash
sqlite3 -bail < ${slug}-test.sql
```

You can find more information in the [sqlite track docs about testing](https://exercism.org/docs/tracks/sqlite/tests).

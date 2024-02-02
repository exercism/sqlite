# SQLite specific instructions

This exercise has two parts.

The first part requires that you populate a `colors` table with all ten colors.
The colors much be "in order" based on the `index` color; that is, an `ORDER BY "index"` must return them in the correct order.

The second part requires you set the `result` column of the `color_code` table to the correct value based on the color found in the `color` column.

## Table Schemas

```sql
CREATE TABLE "colors" ("index" INT, "color" TEXT);
CREATE TABLE "color_code" ("color" TEXT, "result" INT);
```

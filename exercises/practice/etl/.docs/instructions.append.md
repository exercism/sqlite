# SQLite specific instructions

This exercise requires you set the `result` column of the `etl` table to the correct value based on the JSON object found in the `input` column. The keys in the result object must be sorted alphabetically.

## Table Schema

```sql
CREATE TABLE "etl" ("input" TEXT, "result" TEXT);
```

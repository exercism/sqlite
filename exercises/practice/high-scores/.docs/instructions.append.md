# SQLite-specific instructions

To populate the `results` table, there are four "properties" you must consider:

* **scores**: You must aggregate all scores for each `game_id`, and store the scores in a comma-separated string.
  The scores must appear in the same order as they were inserted into the `scores` table.
* **latest**: You must find the last score inserted into the `scores` table.
* **personalBest**: Find the maximum score for each `game_id`.
* **personalTopThree**: Find the three highest scores for each `game_id`, and aggregate them into a comma-separated string, sorted in descending order.

# Notes for Models

## What is a Model?

- A dbt is simply just a sql file in your models folder
- A model is just a *SELECT* statement
- When you run dbt run
    1. Reads the file
    2. Wraps it in a *CREATE TABLE* or a *CREATE VIEW*
    3. Executes it against your database
    4. Creates a table/view with transformed data

## What does a Model do?

- A dbt model is where you write SQL queries that:
    1. **Read** data from source table (or seeds)
    2. **Transform** it (clean, join, aggregate, filter)
    3. **Write** results back in a new table
- Think of cooking
    1. Wash vegetables, peel onions
    2. Chop, mix, cook
    3. Plate the food

## Full data flow

1. CSV file (seeds/spotify_data.csv)
         │
         ▼
2. dbt seed (loads CSV into DuckDB as a table called "spotify_data")
         │
         ▼
3. Your model (reads from spotify_data, transforms it)
         │
         ▼
4. Output table (creates a new table called "spotify_analytics" in DuckDB)
         │
         ▼
5. You query it (dbt model or DuckDB CLI)

## When to use Model vs CLI

- Use Model when you will reuse the query or share it with others (Production)
- Use CLI when your exploring, debugging, or doing a one off analysis (Exploratory)

## Workflow

1. Explore in CLI
2. Write the final query as dbt model
3. Verify in CLI

## Process when bulding a model

1. Think about question "What do you want to know?"
2. Look at your data, "What columns are available?"
3. Write SQL: Start simple, then add complexity.
4. Run it: dbt run
5. Check the output: Query the resulting table in DuckDB.
6. Iterate: Add more columns, filters, joins, etc.

## Staging Models - Cleanup Crew

- Purpose - takes the raw data as it is and makes it usable
- Does things like:
  - Renames Columns
  - Cast Data Types
  - Handle Nulls
  - Fix Casing
  - Deduplicate
- Does not do things like:
  - No joins
  - No heavy business
  - No aggregates

## Mart Models - The Answer Keys

- Fact Tables (fct_)
  - **What**: Measurements, events, or transactions
  - **Data**: Numbers you add up (streams, rev, quantity)
  - **Naming**: fct_[process] (fct_[streams], fct[orders])
  - **Ex. Columns**: artist_key, streams, track count

- Dimension Tables (dim_)
  - **What**: Attributes, people, places, or things.
  - **Data**: Descriptive text (artist_name, genre, country)
  - **Naming**: dim_[entity] (fct_[artist], fct[date])
  - **Ex. Columns**: artist_key PK artist_name, followers

## Staging Model Current Situation

- Checking for nulls in `raw_spotify`:

```sql
dev D SELECT COUNT(*) FROM raw_spotify WHERE "Solo Streams (in millions)" is  NULL;
┌──────────────┐
│ count_star() │
│    int64     │
├──────────────┤
│            7 │
└──────────────┘
dev D SELECT COUNT(*) FROM raw_spotify WHERE "Lead Streams (in millions)"  is  NULL;
┌──────────────┐
│ count_star() │
│    int64     │
├──────────────┤
│            3 │
└──────────────┘
dev D SELECT COUNT(*) FROM raw_spotify WHERE "Feature Streams (in millions)"  is  NULL;
┌──────────────┐
│ count_star() │
│    int64     │
├──────────────┤
│           32 │
└──────────────┘
```

- **Result**: There are 42 rows with NULL values over 3 different columns
- **Diagnosis**: We have to find a way to fill these null values without affecting the data
  - What I have determined is that the reason the null values are there is because the artist most likely has 0 streams as features/solo/lead. So we will fill those values with 0.

- **SQL Reminders**:

1. Using SELECT with COALESCE(column_name, fill_value) - this fills the value
2. If the column name has a space or special characters when selecting surround by quotes

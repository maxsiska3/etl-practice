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
- Use CLI when you're exploring, debugging, or doing a one off analysis (Exploratory)

## Workflow

1. Explore in CLI
2. Write the final query as dbt model
3. Verify in CLI

## Process when building a model

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
  - No heavy business logic
  - No aggregates

## Mart Models - The Answer Keys

- Fact Tables (fct_)
  - **What**: Measurements, events, or transactions
  - **Data**: Numbers you add up (streams, rev, quantity)
  - **Naming**: fct_[process] (fct_streams, fct_orders)
  - **Ex. Columns**: artist_key, streams, track count

- Dimension Tables (dim_)
  - **What**: Attributes, people, places, or things.
  - **Data**: Descriptive text (artist_name, genre, country)
  - **Naming**: dim_[entity] (dim_artist, dim_date)
  - **Ex. Columns**: artist_key PK artist_name, followers

## Staging Model Current Situation

### Checking for nulls in `raw_spotify`

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
- **Implementation**: Renamed column headers and filled nulls with 0 - complete

### SQL Reminders

1. Using SELECT with COALESCE(column_name, fill_value) - this fills the value
2. If the column name has a space or special characters when selecting surround by quotes

## Mart Model Current Situation

### Models we can make *Date of CSV file is 07/17/2026*

1. Artist Stream Summary - complete
2. Average Streams by Genre - complete
3. Average Streams by Country - complete
4. Top 5 Languages by Total Streams - complete
5. Top 10 Artist by Total Streams - complete

### New Discovery: we have a small sample size problem

```sql
dev D SELECT COUNT(primary_genre) as count_genre, primary_genre FROM dim_artist__summary GROUP BY primary_genre ORDER BY count_genre;
┌─────────────┬──────────────────┐
│ count_genre │  primary_genre   │
│    int64    │     varchar      │
├─────────────┼──────────────────┤
│           1 │ Nu Metal         │
│           1 │ Children's Music │
│           1 │ Spoken Word      │
│           2 │ Reggae           │
│           2 │ Afrobeats        │
│           3 │ Soundtrack       │
│           3 │ Bachata          │
│           3 │ Soul             │
│           4 │ Folk             │
│           8 │ Metal            │
│           9 │ Alternative      │
│           9 │ Sertanjeo        │
│          10 │ Country          │
│          11 │ Filmi            │
│          11 │ K-Pop            │
│          19 │ Regional Mexican │
│          22 │ EDM              │
│          30 │ Latin            │
│          31 │ R&B              │
│          43 │ Reggaeton        │
│          60 │ Rock             │
│         102 │ Pop              │
│         115 │ Hip-Hop          │
└─────────────┴──────────────────┘
  23 rows              2 columns
```

- **Diagnosis**: In the specific model we might have to filter out genres if they have a count lower than five because they are skewing the graphs
- **Implementation**: Filtered using a having count greater than five after group by

### Same sample size problem, now with country

```sql
dev D SELECT COUNT(country) as count_country, country FROM dim_artist__summary GROUP BY country ORDER BY count_country;
┌───────────────┬─────────────────────┐
│ count_country │       country       │
│     int64     │       varchar       │
├───────────────┼─────────────────────┤
│             1 │ Philippines         │
│             1 │ Denmark             │
│             1 │ Pakistan            │
│             1 │ Chile               │
│             1 │ Belgium             │
│             1 │ Trinidad and Tobago │
│             1 │ Cuba                │
│             1 │ Senegal             │
│             1 │ DR Congo            │
│             1 │ Guatemala           │
│             1 │ South Africa        │
│             1 │ Russia              │
│             1 │ New Zealand         │
│             1 │ Iceland             │
│             1 │ Panama              │
│             1 │ Barbados            │
│             1 │ Nepal               │
│             1 │ Morocco             │
│             1 │ Venezuela           │
│             1 │ Austria             │
│             2 │ Norway              │
│             2 │ Nigeria             │
│             2 │ Dominican Republic  │
│             2 │ Scotland            │
│             2 │ Netherlands         │
│             2 │ Japan               │
│             2 │ Jamaica             │
│             3 │ Italy               │
│             4 │ Ireland             │
│             5 │ France              │
│             5 │ Sweden              │
│             6 │ Spain               │
│             7 │ Australia           │
│             7 │ Germany             │
│             9 │ Argentina           │
│            11 │ South Korea         │
│            13 │ India               │
│            15 │ Brazil              │
│            16 │ Colombia            │
│            18 │ Canada              │
│            27 │ Mexico              │
│            55 │ United Kingdom      │
│           265 │ United States       │
└───────────────┴─────────────────────┘
  43 rows                   2 columns
```

- **Diagnosis**: Same problem as before, we will have to filter out the countries with less than five artists
- **Implementation**: Filtered using a having count greater than five after group by

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
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
5. Iterate: Add more columns, filters, joins, etc.


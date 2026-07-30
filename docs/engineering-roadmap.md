# 🗺️ Data Stack Learning Roadmap

**Target Role:** Analytics Engineer / Data Engineer (Hybrid)  
**Stack:** dbt-core, DuckDB (→ Snowflake/BigQuery), Tableau/PowerBI, Airflow  
**Duration:** ~3–4 months (self-paced)

---

## 🎯 Objective
Build an end-to-end, fully automated data pipeline that:
- Ingests raw data (API/CSV)
- Transforms data using **dbt** with testing & documentation
- Schedules & orchestrates everything with **Airflow**
- Visualizes results in **PowerBI or Tableau**

This project will serve as your portfolio piece and demonstrate real-world data engineering skills.

---

## 📦 Phase 1: Foundation (Weeks 1–3)
**Goal:** Get `dbt` and `DuckDB` working locally, and build your first transformation pipeline.

### Step 1: Set Up Local Environment
- Install `dbt-core` and `dbt-duckdb` adapter.
- Install DuckDB (standalone binary or Python package).
- Follow the official [dbt DuckDB Quickstart](https://docs.getdbt.com/guides/duckdb).

### Step 2: Build Your First dbt Project
- Use a public dataset (NYC Taxi, Airbnb listings, etc.).
- Create a layered pipeline:
  - `staging` → raw data cleaning
  - `intermediate` → joins, aggregations
  - `marts` → final, analysis-ready tables (star schema)
- Run `dbt run` and verify outputs.

### Step 3: Add Data Quality Tests
- Write tests: `not_null`, `unique`, `accepted_values`.
- Run `dbt test` to validate.
- Document your models with `dbt docs generate` and view the docs.

**✅ Milestone:** You have a working dbt project with tests and documentation.

---

## 🕒 Phase 2: Orchestration (Weeks 4–6)
**Goal:** Automate your pipeline using Airflow (or Prefect).

### Step 1: Learn Airflow Fundamentals
- Understand DAGs, Operators, Sensors, and Schedules.
- Run Airflow locally using `docker-compose` (official quickstart).

### Step 2: Containerize Your dbt Project
- Write a `Dockerfile` that includes `dbt`, your project code, and dependencies.
- Build the image and test running `dbt run` inside the container.

### Step 3: Create an Airflow DAG
- Write a DAG that:
  - Triggers daily at 8 AM.
  - Runs `dbt run` inside the Docker container.
  - Then runs `dbt test`.
- Add retries (e.g., 2 retries on failure).
- Add email/slack alerts on failure (optional).

**✅ Milestone:** Your pipeline runs automatically without manual intervention.

---

## 📊 Phase 3: Business Intelligence (Weeks 7–9)
**Goal:** Connect your transformed data to a BI tool and build a dashboard.

### Step 1: Choose Your BI Tool
- **PowerBI** – strong for corporate, mid-market, and Microsoft shops.
- **Tableau** – better for advanced visualizations, often higher pay.
- Pick **one** and focus on it.

### Step 2: Connect to DuckDB
- Install DuckDB ODBC/JDBC driver or use the native connector.
- Import your `marts` tables into the BI tool.

### Step 3: Build a Dashboard
- Create 3–5 charts (KPIs, trends, breakdowns).
- Ensure it's interactive (filters, drill-downs).
- Publish to a service (PowerBI Service or Tableau Public) if possible.

**✅ Milestone:** You have a live dashboard that updates when the pipeline runs.

---

## 🧠 Phase 4: Semantic Layer (Optional, Weeks 10–12)
**Goal:** Define business metrics in a central location for consistency.

### Step 1: Understand the Concept
- Semantic layer = single source of truth for metrics (e.g., "revenue" defined once).
- Learn how it differs from direct SQL in dashboards.

### Step 2: Use dbt’s Semantic Layer (MetricFlow)
- Define metrics like `total_sales`, `active_users` in your dbt project.
- Use `dbt metrics` to query them.
- Connect your BI tool to query metrics directly.

**✅ Milestone:** You have a metrics-first workflow, reducing dashboard inconsistency.

---

## 🚀 The Final Project (Complete End-to-End Pipeline)

Combine all phases into a single portfolio project:

1. **Ingest:** Python script pulling data from a public API (e.g., OpenWeather, Spotify, or FakeStore) every hour/day.
2. **Store:** Load raw JSON/CSV into DuckDB.
3. **Transform:** dbt models to clean, join, and aggregate.
4. **Test:** dbt tests to ensure data quality.
5. **Orchestrate:** Airflow DAG that runs the ingestion script, then dbt run/test, all on a schedule.
6. **Visualize:** Dashboard showing the latest metrics.

**Host everything on GitHub** with a detailed README explaining:
- Architecture diagram
- Setup instructions
- How to run the pipeline
- Sample dashboard screenshots

---

## 📚 Recommended Resources

| Resource | Link |
|----------|------|
| dbt Developer Hub | [docs.getdbt.com](https://docs.getdbt.com) |
| DuckDB + dbt Quickstart | [docs.getdbt.com/guides/duckdb](https://docs.getdbt.com/guides/duckdb) |
| Airflow Official Tutorial | [airflow.apache.org/docs/apache-airflow/stable/tutorial.html](https://airflow.apache.org/docs/apache-airflow/stable/tutorial.html) |
| PowerBI Learning Path | [Microsoft Learn](https://learn.microsoft.com/en-us/power-bi/) |
| Tableau Public | [public.tableau.com](https://public.tableau.com) |
| "Designing Data-Intensive Applications" (book) | For conceptual depth (read Chapters 1–4) |

---

## ✅ Summary of Skills You'll Build

| Skill | Tool | Level |
|-------|------|-------|
| Data Modeling | dbt-core | Intermediate |
| SQL | DuckDB / Snowflake | Advanced |
| Python | Scripting & Airflow | Intermediate |
| Orchestration | Apache Airflow | Beginner→Intermediate |
| BI Visualization | PowerBI / Tableau | Intermediate |
| Data Testing & Documentation | dbt | Intermediate |
| Version Control | Git/GitHub | Essential |
| Containerization | Docker | Beginner |

---

## ⏱️ Estimated Time Commitment

| Phase | Duration | Weekly Hours |
|-------|----------|--------------|
| Phase 1 | 3 weeks | 5–7 hrs |
| Phase 2 | 3 weeks | 5–7 hrs |
| Phase 3 | 3 weeks | 4–6 hrs |
| Phase 4 (optional) | 2 weeks | 4–6 hrs |
| Final Project | 2 weeks | 8–10 hrs |

**Total:** ~3–4 months (can be compressed or extended as needed).

---

## 🎯 Next Action (Right Now)

1. Install `dbt` and `duckdb` on your local machine.
2. Follow the dbt DuckDB Quickstart guide.
3. Pick a public dataset and start building your first model.
4. Commit everything to a GitHub repo.

**You are now on the path to becoming a competitive Analytics Engineer.**
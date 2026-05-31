<div align="center">

# 🗄️ Sales Data Analysis — SQL

**Financial analysis of a synthetic e-commerce dataset using PostgreSQL — 28 queries, 5 tables, reusable financial views**

[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-14+-336791?style=for-the-badge&logo=postgresql&logoColor=white)](https://postgresql.org)
[![SQL](https://img.shields.io/badge/SQL-Financial%20Analysis-4479A1?style=for-the-badge)](https://github.com/Tuluntas09/sales-data-analysis-sql)
[![Dataset](https://img.shields.io/badge/Dataset-Synthetic%20Retail-1B2536?style=for-the-badge)](https://github.com/Tuluntas09/sales-data-analysis-sql)

</div>

---

## Overview

A finance-oriented SQL case study that transforms raw e-commerce transactions into actionable business insights. Built on a realistic synthetic retail dataset covering 12 months of sales data across 5 product categories, 4 customer segments, and 5 regions. Designed as a portfolio project for Financial Analyst and Business Analyst roles.

---

## Key Findings

| Finding | Result |
|---------|--------|
| 💰 Net Revenue | **$143,723** across 706 completed orders |
| 📊 Gross Profit | **$63,760** · Gross Margin **44.4%** |
| 🏆 Highest margin category | **Beauty & Personal Care — 74.0%** |
| ⚠️ Lowest margin category | **Electronics — 27.8%** (36.2% of revenue) |
| 👑 Best customer segment | **Premium — 45.7% margin**, lowest discount rate (3.3%) |
| 🎯 Budget target hit rate | **3 of 12 months** — 75% miss rate signals over-budgeting |
| 💸 Discount impact | Each tier costs ~**2pp of margin** (46.2% → 45.4% → 42.2%) |

---

## Features

| Feature | Description |
|---------|-------------|
| 🏗️ **Schema Design** | 5-table relational schema with PK/FK/CHECK constraints |
| ✅ **Data Quality** | 30+ validation queries before any analysis |
| 📐 **Financial View** | `vw_completed_order_financials` — single source of truth for all metrics |
| 📈 **Revenue Analysis** | Monthly trend, MoM change, seasonality |
| 🏷️ **Category Profitability** | Revenue share vs. margin by category |
| 👥 **Customer Segments** | AOV, margin, discount rate per segment |
| 🗺️ **Regional Performance** | Revenue and margin by geography |
| 🎫 **Discount Impact** | Margin erosion by discount tier |
| 🎯 **Budget Variance** | Actual vs. monthly targets — 12-month tracking |
| 📋 **Management Report** | Findings + 6 actionable recommendations |

---

## Tech Stack

| Layer | Technology |
|-------|-----------|
| **Database** | PostgreSQL 14+ |
| **Query Language** | SQL — DDL, DML, views, aggregations, window functions |
| **Data** | Synthetic CSV (5 tables, 3,122 total rows) |
| **Documentation** | Markdown — business insights, executive summary, data dictionary |
| **Tools** | psql · DBeaver / pgAdmin |

---

## Data Sources

| Table | Rows | Description |
|-------|------|-------------|
| `customers` | 150 | Segments (Consumer, Corporate, Premium, Small Biz) · 5 regions |
| `products` | 50 | 6 categories · unit cost + selling price |
| `orders` | 800 | 706 completed · 64 cancelled · 30 refunded |
| `order_items` | 2,110 | Quantity · price · discount rate (0–15%) |
| `monthly_targets` | 12 | Revenue + gross profit budget per month |

---

## Architecture

```
data/ (CSV files)
      │
      ▼
01_create_tables.sql       ← Schema: PK, FK, CHECK constraints
      │
      ▼
02_import_data.sql         ← COPY from CSV into 5 tables
      │
      ▼
03_data_quality_checks.sql ← 30+ row count, null, range validations
      │
      ▼
04_financial_metrics_views.sql ← vw_completed_order_financials
      │                           (revenue, cost, margin, discount)
      ▼
05_analysis_queries.sql    ← 28 queries across 10 business sections
      │
      ▼
reports/
  ├── business_insights.md    ← Detailed findings (14 sections)
  └── executive_summary.md    ← Management summary + recommendations
```

---

## Local Setup

```bash
# 1. Clone
git clone https://github.com/Tuluntas09/sales-data-analysis-sql.git
cd sales-data-analysis-sql

# 2. Create database
psql -U postgres -c "CREATE DATABASE financial_analysis;"

# 3. Run scripts in order
psql -U postgres -d financial_analysis -f sql/01_create_tables.sql
psql -U postgres -d financial_analysis -f sql/02_import_data.sql
psql -U postgres -d financial_analysis -f sql/03_data_quality_checks.sql
psql -U postgres -d financial_analysis -f sql/04_financial_metrics_views.sql
psql -U postgres -d financial_analysis -f sql/05_analysis_queries.sql

# 4. Read the reports
# reports/business_insights.md   — full findings
# reports/executive_summary.md   — management summary
```

---

## Project Structure

```
sales-data-analysis-sql/
├── data/
│   ├── customers.csv                  #   150 rows
│   ├── products.csv                   #   50 rows
│   ├── orders.csv                     #   800 rows
│   ├── order_items.csv                #   2,110 rows
│   └── monthly_targets.csv            #   12 rows
├── sql/
│   ├── 01_create_tables.sql
│   ├── 02_import_data.sql
│   ├── 03_data_quality_checks.sql
│   ├── 04_financial_metrics_views.sql
│   └── 05_analysis_queries.sql        #   28 queries · 10 sections
├── reports/
│   ├── business_insights.md
│   └── executive_summary.md
└── docs/
    ├── data_dictionary.md
    └── project_methodology.md
```

---

## Key Technical Decisions

- **Synthetic data over real data** — full control over schema integrity, margin distribution, and seasonal patterns without data privacy concerns
- **Centralized financial view** — `vw_completed_order_financials` ensures every query uses identical metric definitions; no inconsistent calculations across analyses
- **Completed orders only** — cancelled and refunded orders excluded from financial analysis to reflect actual realized revenue
- **Gross profit scope** — operating expenses, taxes, and shipping excluded deliberately; scope is clearly documented to avoid misinterpretation
- **CHECK constraints at schema level** — `discount_rate BETWEEN 0 AND 0.25`, `standard_price > unit_cost` enforced in DDL rather than relying on application logic
- **Numbered script files** — execution order is explicit (01 → 05), eliminating ambiguity about dependencies

---

## Related Projects

- [financial-dashboard-powerbi](https://github.com/Tuluntas09/financial-dashboard-powerbi) — Power BI · 4-page visual layer built on this dataset
- [apple-dcf-scenario-analysis](https://github.com/Tuluntas09/apple-dcf-scenario-analysis) — Python · FRED API · DCF valuation with macro scenarios
- [tcmb-macro-panel](https://github.com/Tuluntas09/tcmb-macro-panel) — Streamlit · TCMB EVDS API · live Turkish macro indicators

---

<div align="center">

*Built for Financial Analyst / Business Analyst portfolio · Synthetic dataset · Not real company data*

**[Tuluntas09](https://github.com/Tuluntas09)**

</div>
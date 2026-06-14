# Sales Data Analysis SQL

Finance-oriented PostgreSQL case study that transforms synthetic e-commerce
transactions into revenue, margin, discount, customer segment, regional, and
budget variance insights.

[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-14+-336791?style=for-the-badge&logo=postgresql&logoColor=white)](https://postgresql.org)
[![SQL](https://img.shields.io/badge/SQL-Financial%20Analysis-4479A1?style=for-the-badge)](sql/)
[![Dataset](https://img.shields.io/badge/Dataset-Synthetic%20Retail-1B2536?style=for-the-badge)](data/)
[![Power BI Companion](https://img.shields.io/badge/Power%20BI-Companion%20Dashboard-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)](https://github.com/Tuluntas09/financial-dashboard-powerbi)
[![License: MIT](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)](LICENSE)

## 30-Second Scan

| Area | What this project shows |
|---|---|
| Business case | Retail/e-commerce financial analysis across orders, products, customers, regions, discounts, and budget targets |
| SQL skills | Schema design, constraints, imports, validation checks, reusable views, aggregations, and window functions |
| Finance skills | Revenue, gross profit, gross margin, AOV, discount impact, MoM change, and budget variance |
| Output | Management-style report, query output samples, data dictionary, and Power BI companion dashboard |
| Portfolio value | Practical FP&A/business analyst case study with reproducible SQL and clear business interpretation |

## Key Findings

| Finding | Result |
|---|---|
| Net revenue | `$143,723` across 706 completed orders |
| Gross profit | `$63,760`, with `44.4%` gross margin |
| Highest margin category | Beauty & Personal Care at `74.0%` margin |
| Lowest margin category | Electronics at `27.8%` margin while contributing `36.2%` of revenue |
| Best customer segment | Premium customers with `45.7%` margin and the lowest discount rate |
| Budget performance | 3 of 12 months met revenue targets |

## Project Flow

```text
data/
  -> 01_create_tables.sql
  -> 02_import_data.sql
  -> 03_data_quality_checks.sql
  -> 04_financial_metrics_views.sql
  -> 05_analysis_queries.sql
  -> reports/ and screenshots/query_outputs/
```

## SQL Assets

| File | Purpose |
|---|---|
| [`01_create_tables.sql`](sql/01_create_tables.sql) | Creates the relational schema with primary keys, foreign keys, and checks |
| [`02_import_data.sql`](sql/02_import_data.sql) | Imports CSV data into PostgreSQL |
| [`03_data_quality_checks.sql`](sql/03_data_quality_checks.sql) | Runs row count, null, range, and referential checks |
| [`04_financial_metrics_views.sql`](sql/04_financial_metrics_views.sql) | Builds reusable financial views |
| [`05_analysis_queries.sql`](sql/05_analysis_queries.sql) | Produces management-level analysis queries |

## Sample Outputs

- [Revenue overview sample](screenshots/query_outputs/01_revenue_overview_sample.md)
- [Category performance sample](screenshots/query_outputs/02_category_performance_sample.md)
- [Budget vs actual sample](screenshots/query_outputs/03_budget_vs_actual_sample.md)

## Local Setup

1. Create a PostgreSQL database.
2. Run the SQL files in order from `sql/01_create_tables.sql` to `sql/05_analysis_queries.sql`.
3. Review documentation in [`docs/data_dictionary.md`](docs/data_dictionary.md) and [`docs/project_methodology.md`](docs/project_methodology.md).
4. Use the companion Power BI project for dashboard presentation:
   [financial-dashboard-powerbi](https://github.com/Tuluntas09/financial-dashboard-powerbi).

Example with `psql`:

```bash
psql -d sales_analysis -f sql/01_create_tables.sql
psql -d sales_analysis -f sql/02_import_data.sql
psql -d sales_analysis -f sql/03_data_quality_checks.sql
psql -d sales_analysis -f sql/04_financial_metrics_views.sql
psql -d sales_analysis -f sql/05_analysis_queries.sql
```

## Validation

- Run `03_data_quality_checks.sql` before interpreting analysis outputs.
- Confirm completed, cancelled, and refunded orders are handled consistently.
- Reconcile revenue and margin figures against query output samples.

## Documentation

- [Project brief](docs/project-brief.md)
- [Methodology](docs/project_methodology.md)
- [Data dictionary](docs/data_dictionary.md)

## License

MIT License. See [LICENSE](LICENSE).

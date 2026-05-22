# SQL-Based Financial Data Analysis

## Project Overview

This project performs SQL-based financial analysis on a realistic synthetic retail/e-commerce dataset. The goal is to transform transactional data into actionable business insights about revenue performance, product profitability, customer segments, regional trends, discount impact, and budget variance.

The dataset is purpose-built to reflect real-world business patterns — varying margins across products, distinct customer segment behaviors, regional performance differences, and seasonal revenue fluctuations. This allows a complete financial analysis workflow from data validation through management recommendations.

The project is designed as a portfolio case study for finance, data, and business analysis roles.

## Why This Project Matters

This is not a SQL tutorial or a technical exercise. It is a **finance-oriented business analysis case study** that demonstrates:

- Understanding of financial business questions
- Ability to design a clean relational database
- Accurate calculation of revenue, cost, gross profit, margin, and variance metrics
- Interpretation of financial results in a business context
- Translation of data into management-level insights and recommendations

The project is structured so that a recruiter, hiring manager, or interviewer can quickly understand what was analyzed, how it was done, and what the findings mean.

## Business Problem

The company needs to understand:

1. Which products and categories generate the most revenue and profit?
2. Are high-revenue products also high-margin products?
3. Which customer segments are the most valuable?
4. Which regions perform strongly or weakly?
5. How do discounts affect profitability?
6. How does revenue and profit change month over month?
7. Is the company meeting its monthly revenue and profit targets?
8. What actions should management consider based on the data?

## Dataset Overview

The analysis uses a controlled synthetic dataset with five relational tables covering January–December 2025:

| Table | Description | Rows |
|---|---|---|
| `customers` | Customer information with segment and region | 150 |
| `products` | Product catalog with unit cost and selling price | 50 |
| `orders` | Order headers with date, channel, payment method, status | 800 |
| `order_items` | Line-item transactions with quantity, price, discount rate | 2,110 |
| `monthly_targets` | Monthly revenue and gross profit budget targets | 12 |

**Segments:** Consumer, Corporate, Small Business, Premium
**Categories:** Electronics, Home & Kitchen, Clothing, Sports & Outdoor, Beauty & Personal Care, Office Supplies
**Regions:** North, South, East, West, Central

Of 800 total orders, 706 (88.3%) are Completed, 64 (8.0%) Cancelled, and 30 (3.8%) Refunded. Financial analysis uses only Completed orders.

## Database Schema

```
customers (1) ──── (N) orders
orders    (1) ──── (N) order_items
products  (1) ──── (N) order_items
monthly_targets (standalone reference table)
```

The schema includes primary keys, foreign keys, and check constraints for data integrity (e.g., `standard_price > unit_cost`, `discount_rate BETWEEN 0 AND 0.25`, `quantity > 0`).

A reusable SQL view (`vw_completed_order_financials`) centralizes all financial metric calculations to ensure consistency across analyses.

## Key Financial Metrics

| Metric | Formula | Description |
|---|---|---|
| Gross Revenue | `quantity × unit_price` | Total sales value before discounts |
| Discount Amount | `quantity × unit_price × discount_rate` | Revenue lost to discounts |
| Net Revenue | `quantity × unit_price × (1 - discount_rate)` | Actual revenue after discounts |
| Total Cost (COGS) | `quantity × unit_cost` | Cost of goods sold |
| Gross Profit | `net_revenue - total_cost` | Profit after product cost |
| Gross Margin | `gross_profit / net_revenue` | Profitability ratio |
| Average Order Value | `total_net_revenue / order_count` | Revenue per order |
| Budget Variance | `actual - target` | Performance vs. plan |

**Important:** This project analyzes **gross profit**, not net profit. Operating expenses, taxes, shipping, and payment fees are not included.

## Main SQL Analysis Sections

| # | Section | Business Question |
|---|---|---|
| 1 | Revenue Overview | What is the company's overall financial position? |
| 2 | Monthly Trend Analysis | Is performance improving or declining over time? |
| 3 | Product-Level Profitability | Which products create the most value? |
| 4 | Category-Level Analysis | Which categories drive revenue vs. margin? |
| 5 | Customer Segment Analysis | Which customer groups are most valuable? |
| 6 | Regional Performance | Where is the company strong or weak? |
| 7 | Discount Impact Analysis | Are discounts helping or hurting profitability? |
| 8 | Budget vs Actual | Is the company meeting its targets? |
| 9 | Cancellation Analysis | How much potential revenue is lost to cancellations? |
| 10 | Management Insights | What should the business do next? |

## Key Findings

### Overall Performance
- **Net Revenue:** $143,723 | **Gross Profit:** $63,760 | **Gross Margin:** 44.4%
- **Average Order Value:** $203.57 across 706 completed orders
- Discount-to-gross-revenue ratio: 4.5%

### Category Insights
- **Electronics** leads revenue (36.2% share) but has the **lowest margin at 27.8%** — it generates nearly half the revenue but less than a quarter of gross profit.
- **Beauty & Personal Care** has the **highest margin at 74.0%** but the smallest revenue share (6.1%), suggesting growth potential.
- **Clothing** delivers strong profitability at 58.7% margin with 16.4% revenue share.

### Customer Segments
- **Consumer** is the volume backbone: 434 orders, $76,039 revenue, 44.8% margin.
- **Corporate** has the **highest AOV ($360)** and highest revenue per customer ($1,753), but also the **highest discount rate (5.7%)** and **lowest margin (43.0%)**.
- **Premium** achieves the best margin (45.7%) with the lowest discount rate (3.3%).

### Regional Performance
- **North** leads with 28.5% revenue share ($40,921) and 207 orders.
- **South** is the weakest region at 12.4% share ($17,795) — a scale issue, not a margin problem (44.2% margin).
- Regional margins are tight (43.5%–44.9%), indicating consistent pricing across geographies.

### Discount Impact
- Discounts stay within 0–15%. No items had discounts above 15%.
- Each discount tier costs approximately **2 percentage points of margin** (46.2% → 45.4% → 42.2%).
- The Medium band (6–15%) generates the most revenue and profit in absolute terms.

### Budget Performance
- The company **met revenue targets in only 3 of 12 months** (May, July, September).
- November had the worst miss: -8.3% ($1,526 below target).
- The 75% miss rate suggests targets may be systematically over-budgeted.

## Management Recommendations

1. **Review Electronics pricing and cost structure** — 36.2% of revenue at 27.8% margin needs attention.
2. **Invest in high-margin categories** — Beauty & Personal Care (74.0%) and Clothing (58.7%) can improve the overall margin mix.
3. **Reassess Corporate discount policy** — 5.7% average discount rate should be justified by incremental volume.
4. **Grow South region volume** — Margin is healthy (44.2%); the opportunity is in scale.
5. **Recalibrate budget targets** — A 75% miss rate indicates the target-setting process needs revision.
6. **Monitor moderate discounts** — The 6–15% band is productive but should be reviewed to prevent margin drift.

## Tools Used

- **SQL** (PostgreSQL) — Database schema, data quality checks, financial views, analysis queries
- **CSV** — Structured data storage and import
- **Markdown** — Documentation, business reports, executive summary
- **GitHub** — Version control and portfolio presentation

## Project Structure

```
sql-financial-analysis/
├── data/                              # CSV datasets
│   ├── customers.csv                  #   150 customers
│   ├── products.csv                   #   50 products
│   ├── orders.csv                     #   800 orders
│   ├── order_items.csv                #   2,110 line items
│   └── monthly_targets.csv            #   12 monthly targets
├── sql/                               # SQL scripts (run in order)
│   ├── 01_create_tables.sql           #   Schema with PK/FK/CHECK
│   ├── 02_import_data.sql             #   CSV import via \copy
│   ├── 03_data_quality_checks.sql     #   30+ validation queries
│   ├── 04_financial_metrics_views.sql #   Reusable financial views
│   └── 05_analysis_queries.sql        #   10-section analysis (28 queries)
├── reports/                           # Business reports
│   ├── business_insights.md           #   Detailed findings (14 sections)
│   └── executive_summary.md           #   Management summary + CV bullets
├── docs/                              # Documentation
│   ├── data_dictionary.md             #   Table/column definitions
│   └── project_methodology.md         #   Approach and metric logic
├── screenshots/query_outputs/         # Sample query output previews
│   ├── 01_revenue_overview_sample.md
│   ├── 02_category_performance_sample.md
│   └── 03_budget_vs_actual_sample.md
└── README.md
```

## How to Run

### Prerequisites
- PostgreSQL (or SQLite with syntax adjustments)
- psql terminal or a database client (DBeaver, pgAdmin, DataGrip)

### Steps

1. Clone the repository:
   ```
   git clone https://github.com/<username>/sql-financial-analysis.git
   cd sql-financial-analysis
   ```

2. Create a PostgreSQL database:
   ```sql
   CREATE DATABASE financial_analysis;
   ```

3. Run SQL scripts in order from the project root:
   ```
   psql -U <username> -d financial_analysis -f sql/01_create_tables.sql
   psql -U <username> -d financial_analysis -f sql/02_import_data.sql
   psql -U <username> -d financial_analysis -f sql/03_data_quality_checks.sql
   psql -U <username> -d financial_analysis -f sql/04_financial_metrics_views.sql
   psql -U <username> -d financial_analysis -f sql/05_analysis_queries.sql
   ```

4. Review the business reports:
   - [`reports/business_insights.md`](reports/business_insights.md) — Full analysis findings
   - [`reports/executive_summary.md`](reports/executive_summary.md) — Management summary

## Limitations

- Uses realistic synthetic data, not real company data. Data patterns are designed to reflect common retail business dynamics.
- Covers **gross profit only**; operating expenses, salaries, rent, and marketing spend are not included.
- No tax, shipping, or payment processing fee calculations.
- Budget targets are company-level only, not broken down by region, category, or segment.
- The analysis covers a single year (2025); year-over-year comparisons are not possible.
- This is a static SQL analysis, not a live reporting or dashboard system.

## Future Improvements

- **Power BI Dashboard** — Interactive visualization of monthly trends, category performance, and regional comparisons
- **Operating Expense Layer** — Add OPEX data to calculate net profit and contribution margin
- **Real-World Dataset Comparison** — Apply the same framework to a public dataset (e.g., UCI Online Retail)
- **Customer Cohort Analysis** — Analyze retention and repeat purchase behavior by signup period
- **Automated Monthly Reporting** — Build a scheduled SQL reporting pipeline

## CV / Portfolio Summary

**English:**
Performed SQL-based financial analysis on a realistic synthetic retail dataset, evaluating net revenue, cost structure, gross profit, gross margin, customer segments, category profitability, regional performance, discount impact, and budget variance across 706 orders and 50 products; translated query results into a structured management report with actionable recommendations.

**Turkish:**
Gerçekçi sentetik perakende veri seti üzerinde SQL tabanlı finansal analiz gerçekleştirdim; 706 sipariş ve 50 ürün üzerinden net gelir, maliyet yapısı, brüt kâr, brüt marj, müşteri segmenti, kategori kârlılığı, bölgesel performans, indirim etkisi ve bütçe sapması değerlendirmesi yaptım. Sorgu sonuçlarını yapılandırılmış bir yönetim raporuna ve aksiyon önerilerine dönüştürdüm.

---

*This project demonstrates practical SQL, financial analysis, and business reasoning skills applied to a realistic synthetic retail dataset.*

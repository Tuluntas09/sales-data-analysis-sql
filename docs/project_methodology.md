# Project Methodology

This document explains the analytical approach, financial metric definitions, and project phases used in this SQL-based financial data analysis.

---

## Analytical Approach

The project follows a structured approach to financial data analysis:

1. **Data Preparation** — Design a relational database schema and populate it with realistic sample data.
2. **Data Validation** — Run quality checks to confirm data integrity before analysis.
3. **Metric Standardization** — Create a reusable SQL view that centralizes all financial metric calculations.
4. **Business Analysis** — Execute SQL queries organized by business question.
5. **Insight Generation** — Interpret query results and write management-level findings.

This approach ensures that financial metrics are calculated consistently across all analyses and that conclusions are traceable back to specific queries and data.

---

## Financial Metric Definitions

### Gross Revenue

The total sales value before any discounts are applied.

**Formula:** `quantity * unit_price`

**Use:** Measures total demand and sales activity.

### Discount Amount

The monetary value of discounts given on sales.

**Formula:** `quantity * unit_price * discount_rate`

**Use:** Measures the cost of discounting strategy.

### Net Revenue

The actual revenue received after discounts.

**Formula:** `quantity * unit_price * (1 - discount_rate)`

**Use:** Represents the true top-line revenue for financial performance evaluation.

### Total Cost (COGS)

The cost of goods sold for the products in each transaction.

**Formula:** `quantity * unit_cost`

**Use:** Measures the direct cost base of sales.

### Gross Profit

The profit remaining after subtracting cost of goods from net revenue.

**Formula:** `net_revenue - total_cost`

**Use:** Shows how much value the company retains after product costs. This is the primary profitability metric in this project.

### Gross Margin

The gross profit expressed as a percentage of net revenue.

**Formula:** `gross_profit / net_revenue`

**Division safety:** When net revenue equals zero, gross margin is returned as NULL to avoid division errors.

**Use:** Allows profitability comparison across products, categories, segments, and regions regardless of scale.

### Average Order Value (AOV)

The average net revenue per order.

**Formula:** `total_net_revenue / number_of_orders`

**Use:** Indicates customer spending behavior per transaction.

### Budget Variance

The difference between actual performance and target.

**Formula:** `actual - target`

**Variance percentage:** `(actual - target) / target`

**Use:** Shows whether the company overperformed or underperformed relative to its monthly plan.

---

## Key Analytical Assumptions

1. Only completed orders are included in financial analysis. Cancelled and refunded orders are excluded.
2. Discount rate is stored as a decimal (e.g., 0.10 = 10%).
3. Unit cost comes from the products table and represents cost of goods sold per unit.
4. The project analyzes gross profit only. Operating expenses, taxes, shipping, and payment fees are not included.
5. Budget targets are set at company level per month; no regional or category-level targets exist.
6. All monetary values are in a single currency.

---

## Analysis Sections

The SQL analysis is organized into 10 sections, each answering specific business questions:

| Section | Focus | Key Question |
|---|---|---|
| 1. Data Quality Checks | Validation | Is the data reliable for analysis? |
| 2. Revenue Overview | Summary | What is the company's overall financial position? |
| 3. Monthly Trends | Time series | Is performance improving or declining over time? |
| 4. Product Profitability | Product level | Which products create the most value? |
| 5. Category Analysis | Category level | Which categories drive revenue vs. margin? |
| 6. Customer Segments | Segmentation | Which customer groups are most valuable? |
| 7. Regional Performance | Geography | Where is the company strong or weak? |
| 8. Discount Impact | Pricing | Are discounts helping or hurting profitability? |
| 9. Budget vs Actual | Planning | Is the company meeting its targets? |
| 10. Management Insights | Synthesis | What should the business do next? |

---

## Project Phases

| Phase | Deliverable | Purpose |
|---|---|---|
| 1. Project Setup | Folder structure, README, documentation | Define scope and structure |
| 2. Dataset Design | 5 CSV files with realistic sample data | Provide data foundation |
| 3. Database Creation | Table creation and data import scripts | Build the relational schema |
| 4. Data Quality | Validation queries | Confirm data integrity |
| 5. Financial Views | Reusable metrics view | Standardize calculations |
| 6. Analysis Queries | 10-section SQL analysis | Answer business questions |
| 7. Business Report | Insights report and executive summary | Translate data into decisions |
| 8. Portfolio Polish | Final README, screenshots, CV bullets | Make project presentation-ready |

---

## Scope Boundaries

This project intentionally excludes:

- Machine learning or predictive modeling
- Real-time data pipelines or API integrations
- Web applications or interactive dashboards
- Operating expense analysis or net profit calculations
- Tax, shipping, or payment fee modeling
- Investment recommendations or financial advice

These boundaries keep the project focused on SQL analysis and financial reasoning, which is the core skill being demonstrated.

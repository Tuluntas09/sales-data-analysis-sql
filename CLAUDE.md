# CLAUDE.md — SQL Financial Data Analysis Project

## 1. Project Identity

### Project Name
SQL-Based Financial Data Analysis Portfolio Project

### Short Description
This project is a portfolio-level financial data analysis project designed for an Economics & Finance graduate who wants to demonstrate practical SQL, financial analysis, business reasoning, and reporting skills.

The project analyzes a fictional retail/e-commerce company’s sales, product, customer, cost, discount, and budget data using SQL. The goal is to transform raw transactional data into business insights about revenue, cost, gross profit, margins, customer segments, regional performance, product profitability, discount impact, and budget vs actual performance.

### Core Positioning
This is not only a technical SQL exercise. It is a finance-oriented business analysis project.

The project should prove that the owner can:

- Understand financial business questions
- Design a clean relational database structure
- Query financial and operational data using SQL
- Calculate revenue, cost, gross profit, margin, and variance metrics
- Interpret the results in a business context
- Translate data into management-level insights
- Present the project professionally on GitHub and in a CV

---

## 2. Target User and Career Purpose

### Project Owner Profile
The project owner is an Economics & Finance graduate / new graduate candidate who can use Claude Code and wants to build a strong portfolio for finance, data, and business analysis roles.

### Target Roles
This project should support applications for roles such as:

- Financial Analyst
- Finance Data Analyst
- Business Analyst
- Junior Data Analyst
- FP&A Analyst
- Reporting Analyst
- Management Reporting Assistant
- BI Analyst Intern / Junior BI Analyst
- Revenue Analyst
- Commercial Finance Analyst

### What This Project Should Signal to Employers
The project should communicate the following message:

> I can work with structured business data, use SQL to extract financial insights, and explain the commercial meaning of the numbers.

This project should not look like a random tutorial. It should look like a real business case study.

---

## 3. Project Objective

### Main Objective
To analyze a company’s transactional and financial data using SQL and produce a clear business insight report that explains revenue performance, profitability drivers, margin structure, customer behavior, discount impact, regional performance, and budget deviations.

### Business Problem
The fictional company wants to understand:

1. Which products and categories generate the most revenue?
2. Which products and categories generate the most gross profit?
3. Are high-revenue products also high-margin products?
4. Which customer segments are the most valuable?
5. Which regions perform strongly or weakly?
6. How do discounts affect profitability?
7. How does monthly revenue and profit change over time?
8. Is the company meeting its monthly revenue and profit targets?
9. Which areas need management attention?
10. What actions should management consider based on the data?

---

## 4. Scope

### In Scope
The project includes:

- Relational database design
- CSV-based mock dataset creation
- Table creation scripts
- Data insertion or import scripts
- SQL queries for financial analysis
- Revenue, cost, gross profit, gross margin calculations
- Product-level analysis
- Category-level analysis
- Customer segment analysis
- Regional performance analysis
- Discount impact analysis
- Monthly trend analysis
- Budget vs actual analysis
- Business insight report
- GitHub-ready README file
- CV-friendly project summary

### Out of Scope
The project should not include the following in the first version:

- Real company confidential data
- Live API integration
- Machine learning
- Advanced forecasting
- Complex data engineering pipelines
- Web application development
- Authentication or user accounts
- Automated dashboards in v1
- Investment recommendation language
- Claims of financial advice

Power BI visualization can be added later as a separate project or extension, but this project’s first version should focus on SQL and financial reasoning.

---

## 5. Recommended Tech Stack

### Required
- SQL
- PostgreSQL or SQLite
- CSV files
- GitHub
- Markdown documentation

### Recommended
- PostgreSQL for a more professional database environment
- DBeaver, pgAdmin, DataGrip, or VS Code SQL extensions
- Excel for inspecting CSV files
- Claude Code for project structuring, SQL review, README writing, and documentation support

### Optional Later Extensions
- Power BI dashboard
- Python data validation script
- ERD diagram
- dbdiagram.io schema visualization
- Streamlit mini dashboard

---

## 6. Database Theme

### Fictional Company
The fictional company can be named:

**Northwind Retail Analytics**

Alternative names:

- NovaMart Retail
- Atlas Commerce
- Meridian Retail Group
- UrbanCart Analytics

Use one consistent company name across the project.

### Business Type
A fictional retail/e-commerce company that sells products across multiple categories and regions.

### Product Categories
Example categories:

- Electronics
- Home & Kitchen
- Clothing
- Sports & Outdoor
- Beauty & Personal Care
- Office Supplies

### Customer Segments
Example segments:

- Consumer
- Corporate
- Small Business
- Premium

### Regions
Example regions:

- North
- South
- East
- West
- Central

If using Turkey-focused data later, regions can be changed to:

- Marmara
- Ege
- İç Anadolu
- Akdeniz
- Karadeniz
- Doğu Anadolu
- Güneydoğu Anadolu

For the first version, keep region names simple and international.

---

## 7. Data Model

The database should contain 5 main tables.

### 7.1 customers
Stores customer-level information.

Recommended columns:

- customer_id
- customer_name
- segment
- city
- region
- signup_date

Purpose:
This table allows customer segmentation, region-level analysis, and customer value analysis.

---

### 7.2 products
Stores product-level information.

Recommended columns:

- product_id
- product_name
- category
- unit_cost
- standard_price

Purpose:
This table allows product profitability analysis by comparing sales price with cost.

---

### 7.3 orders
Stores order header information.

Recommended columns:

- order_id
- order_date
- customer_id
- payment_method
- sales_channel
- order_status

Purpose:
This table stores when the order happened, who placed the order, and how the order was paid.

---

### 7.4 order_items
Stores product-level line items for each order.

Recommended columns:

- order_item_id
- order_id
- product_id
- quantity
- unit_price
- discount_rate

Purpose:
This table is the core transactional table. Revenue, cost, gross profit, and margin are calculated from this table joined with products.

Important formulas:

- gross_revenue = quantity * unit_price
- discount_amount = quantity * unit_price * discount_rate
- net_revenue = quantity * unit_price * (1 - discount_rate)
- total_cost = quantity * unit_cost
- gross_profit = net_revenue - total_cost
- gross_margin = gross_profit / net_revenue

---

### 7.5 monthly_targets
Stores monthly budget or target values.

Recommended columns:

- target_month
- target_revenue
- target_gross_profit

Purpose:
This table allows budget vs actual analysis.

---

## 8. Recommended Folder Structure

Use the following project structure:

```text
sql-financial-analysis/
│
├── data/
│   ├── customers.csv
│   ├── products.csv
│   ├── orders.csv
│   ├── order_items.csv
│   └── monthly_targets.csv
│
├── sql/
│   ├── 01_create_tables.sql
│   ├── 02_import_data.sql
│   ├── 03_data_quality_checks.sql
│   ├── 04_financial_metrics_views.sql
│   └── 05_analysis_queries.sql
│
├── reports/
│   ├── business_insights.md
│   └── executive_summary.md
│
├── docs/
│   ├── data_dictionary.md
│   └── project_methodology.md
│
├── screenshots/
│   └── query_outputs/
│
└── README.md
```

Do not overcomplicate the structure in v1. Keep it clear and recruiter-friendly.

---

## 9. SQL Development Rules

### General SQL Style
- Use clear table aliases.
- Use snake_case for column and table names.
- Write readable SQL instead of overly compressed SQL.
- Add comments before each major query.
- Avoid unnecessarily complex techniques in v1.
- Use CTEs when they improve readability.
- Prefer meaningful query names and section headings.

### Financial Accuracy Rules
Always distinguish between:

- Gross revenue before discount
- Net revenue after discount
- Total cost
- Gross profit
- Gross margin

Never call revenue “profit.”
Never interpret high sales volume as high profitability without checking margin.
Never ignore discount impact when calculating actual revenue.

### Division Safety
When calculating margin, avoid division by zero.

Example logic:

```sql
CASE
    WHEN net_revenue = 0 THEN NULL
    ELSE gross_profit / net_revenue
END AS gross_margin
```

### Monetary Formatting
In SQL outputs, keep numeric values as numbers. Formatting can be done in documentation or BI tools later.

---

## 10. Core Financial Metrics

The project should calculate and explain the following metrics.

### Gross Revenue
Revenue before discounts.

Formula:
quantity * unit_price

Meaning:
Shows total listed sales value before discounts.

---

### Discount Amount
The monetary impact of discounts.

Formula:
quantity * unit_price * discount_rate

Meaning:
Shows how much revenue was given away through discounts.

---

### Net Revenue
Revenue after discounts.

Formula:
quantity * unit_price * (1 - discount_rate)

Meaning:
Represents actual sales revenue after discount impact.

---

### Total Cost
Total cost of goods sold.

Formula:
quantity * unit_cost

Meaning:
Shows the cost base of sold products.

---

### Gross Profit
Profit before operating expenses.

Formula:
net_revenue - total_cost

Meaning:
Shows how much value remains after product cost.

---

### Gross Margin
Profitability percentage.

Formula:
gross_profit / net_revenue

Meaning:
Shows how profitable each sale is after product cost.

---

### Average Order Value
Average revenue per order.

Formula:
total_net_revenue / number_of_orders

Meaning:
Shows customer spending level per order.

---

### Budget Variance
Difference between actual and target.

Formula:
actual - target

Variance percentage:
(actual - target) / target

Meaning:
Shows whether the company overperformed or underperformed against target.

---

## 11. Required SQL Analysis Sections

The final SQL analysis file should contain the following sections.

### Section 1 — Data Quality Checks
Purpose:
Verify that the data is usable before analysis.

Queries should check:

- Row counts by table
- Null values in key columns
- Duplicate primary keys
- Orders without customers
- Order items without products
- Negative quantities
- Negative prices
- Discount rates below 0 or above 1
- Order statuses distribution

Business explanation:
Before making financial conclusions, the dataset should be checked for basic quality issues.

---

### Section 2 — Revenue Overview
Purpose:
Understand total revenue and profit base.

Queries:

- Total gross revenue
- Total discount amount
- Total net revenue
- Total cost
- Total gross profit
- Overall gross margin
- Total number of orders
- Total quantity sold
- Average order value

Expected insight:
This gives the executive summary of company performance.

---

### Section 3 — Monthly Trend Analysis
Purpose:
Analyze revenue, cost, profit, and margin over time.

Queries:

- Monthly net revenue
- Monthly gross profit
- Monthly gross margin
- Monthly order count
- Month-over-month revenue growth

Expected insight:
This shows whether performance is improving, declining, or volatile.

---

### Section 4 — Product-Level Profitability
Purpose:
Identify which products create the most value.

Queries:

- Top products by net revenue
- Top products by gross profit
- Top products by quantity sold
- Lowest-margin products
- High-revenue but low-margin products

Expected insight:
High sales volume does not always mean strong profitability.

---

### Section 5 — Category-Level Analysis
Purpose:
Understand which product categories are most important.

Queries:

- Category revenue
- Category gross profit
- Category gross margin
- Category sales volume
- Category contribution to total revenue

Expected insight:
Some categories may drive revenue, while others drive margin.

---

### Section 6 — Customer Segment Analysis
Purpose:
Analyze business value by customer segment.

Queries:

- Revenue by customer segment
- Gross profit by customer segment
- Average order value by segment
- Gross margin by segment
- Number of active customers by segment

Expected insight:
Some customer segments may buy more frequently, while others may generate higher margin.

---

### Section 7 — Regional Performance Analysis
Purpose:
Understand geographic strengths and weaknesses.

Queries:

- Revenue by region
- Gross profit by region
- Gross margin by region
- Order count by region
- Average order value by region

Expected insight:
A region with high revenue may still have weak profitability if discounting or product mix is poor.

---

### Section 8 — Discount Impact Analysis
Purpose:
Measure whether discounts support or hurt profitability.

Queries:

- Revenue and margin by discount band
- Average discount rate by category
- Average discount rate by segment
- High-discount orders and their margin
- Comparison of discounted vs non-discounted sales

Discount bands:

- No discount: 0%
- Low discount: >0% and <=5%
- Medium discount: >5% and <=15%
- High discount: >15%

Expected insight:
Discounts may increase sales volume but reduce gross margin.

---

### Section 9 — Budget vs Actual Analysis
Purpose:
Compare performance against targets.

Queries:

- Monthly actual revenue vs target revenue
- Monthly actual gross profit vs target gross profit
- Revenue variance
- Revenue variance percentage
- Gross profit variance
- Gross profit variance percentage
- Months above target
- Months below target

Expected insight:
Management can identify underperforming months and possible causes.

---

### Section 10 — Management Insights
Purpose:
Turn SQL outputs into business recommendations.

The report should answer:

- What is going well?
- What is underperforming?
- Which products/categories deserve attention?
- Are discounts helping or hurting?
- Which customer segments are attractive?
- Which regions require management action?
- What should the business do next?

---

## 12. Suggested Analytical Views

Create a reusable SQL view for line-item level financial metrics.

Suggested view name:

```sql
vw_order_item_financials
```

Purpose:
Avoid repeating the same revenue, cost, and profit formulas in every query.

The view should join:

- order_items
- orders
- products
- customers

Recommended columns:

- order_id
- order_date
- order_month
- customer_id
- customer_name
- segment
- region
- product_id
- product_name
- category
- quantity
- unit_price
- unit_cost
- discount_rate
- gross_revenue
- discount_amount
- net_revenue
- total_cost
- gross_profit
- gross_margin
- sales_channel
- payment_method
- order_status

Only include completed orders in the main financial analysis unless otherwise stated.

---

## 13. Dataset Requirements

### Dataset Size
The dataset should be large enough to look realistic but not too large for a portfolio project.

Recommended size:

- customers: 100–300 rows
- products: 30–80 rows
- orders: 500–2,000 rows
- order_items: 1,000–5,000 rows
- monthly_targets: 12–24 rows

### Time Period
Use at least 12 months of data.

Recommended:
January 2025 to December 2025

Alternative:
January 2024 to December 2025 for 24-month analysis.

### Data Realism Rules
- Not every product should have the same margin.
- Premium segment should generally have higher average order value.
- Some categories should have higher margin than others.
- Discounts should vary by product, category, and sales channel.
- Some regions should have higher revenue but lower margin.
- Monthly revenue should not be perfectly smooth.
- Targets should be realistic but not always achieved.

---

## 14. Business Logic Assumptions

Use the following assumptions unless changed intentionally:

1. Only completed orders count toward financial performance.
2. Cancelled or refunded orders should be excluded from revenue analysis.
3. Discount rate is stored as a decimal, e.g. 0.10 means 10%.
4. Unit cost comes from the products table.
5. Revenue is calculated at order item level.
6. Gross profit is calculated after discounts and product cost.
7. Operating expenses are not included in v1.
8. Therefore, this project analyzes gross profit, not net profit.
9. Budget targets are monthly and company-level.
10. No tax, shipping cost, or payment fees are included in v1.

---

## 15. Expected Final Deliverables

The completed project should include:

### 1. Database Scripts
- Table creation script
- Data import script
- Data quality checks
- Financial metrics view
- Analysis queries

### 2. Dataset
- Clean CSV files
- Consistent IDs
- Realistic sample data

### 3. Documentation
- README.md
- Data dictionary
- Methodology file
- Business insights report
- Executive summary

### 4. Portfolio Assets
- Screenshots of key query outputs
- GitHub repository
- CV bullet points
- Optional LinkedIn post summary

---

## 16. README Requirements

The README should include:

1. Project title
2. Short project description
3. Business problem
4. Dataset overview
5. Database schema summary
6. Key financial metrics
7. Main SQL analyses
8. Key business insights
9. Tools used
10. Folder structure
11. How to run the project
12. Limitations
13. Possible future improvements

The README should be written for recruiters, not only developers.

Avoid overly technical explanations without business meaning.

---

## 17. Business Insights Report Structure

The business_insights.md file should include:

### 1. Executive Summary
A short overview of company performance.

### 2. Revenue Performance
Explain total revenue and monthly trend.

### 3. Profitability Performance
Explain gross profit and margin structure.

### 4. Product and Category Insights
Explain which products and categories drive revenue and margin.

### 5. Customer Segment Insights
Explain which customer segments are most valuable.

### 6. Regional Insights
Explain regional strengths and weaknesses.

### 7. Discount Impact
Explain whether discounting is helping or hurting profitability.

### 8. Budget vs Actual
Explain whether the company met revenue and profit targets.

### 9. Management Recommendations
Provide 3–5 actionable recommendations.

### 10. Limitations
Explain project assumptions and what is not included.

---

## 18. Example Management Recommendations

Recommendations should be specific and connected to SQL results.

Good examples:

- Reevaluate high-discount products with below-average gross margin.
- Prioritize categories with both strong revenue contribution and above-average margin.
- Investigate regions where revenue is high but profitability is weak.
- Increase focus on customer segments with high average order value and stable margin.
- Review monthly underperformance against targets and compare with discount intensity.

Bad examples:

- Increase sales.
- Reduce costs.
- Improve marketing.
- Make more profit.

Recommendations must be evidence-based.

---

## 19. CV Positioning

### Turkish CV Bullet
SQL kullanarak satış ve finans verileri üzerinde gelir, maliyet, brüt kâr, kâr marjı, müşteri segmenti ve bölge bazlı performans analizi gerçekleştirdim. Sorgu sonuçlarını iş içgörülerine dönüştürerek kısa bir yönetim raporu hazırladım.

### English CV Bullet
Performed SQL-based financial data analysis on sales and cost datasets to evaluate revenue trends, gross margins, customer segments, regional performance and budget variances; summarized insights in a business report.

### More Technical English CV Bullet
Designed a relational database and SQL analysis workflow for a fictional retail company, calculating net revenue, cost, gross profit, gross margin, customer segment performance, regional trends and budget variances using reusable SQL views and CTE-based queries.

---

## 20. Claude Code Working Rules

Claude Code should follow these rules throughout the project.

### General Behavior
- Work carefully and incrementally.
- Keep the project portfolio-focused.
- Do not overcomplicate the first version.
- Explain what each file does before creating or changing it.
- Prefer clean structure over excessive features.
- Keep the financial logic accurate.
- Ask for confirmation before destructive actions.

### Code Generation Rules
- Use clear SQL formatting.
- Add comments to SQL files.
- Avoid unnecessary advanced SQL unless useful.
- Keep file names consistent with the folder structure.
- Do not create random unrelated files.
- Do not add a web app unless explicitly requested.

### Data Rules
- If mock data is generated, make it realistic.
- Keep IDs consistent across tables.
- Avoid impossible values such as negative quantity or discount above 100% unless intentionally used for data quality checks.
- Use completed/cancelled/refunded order statuses.
- Financial analysis should normally use completed orders only.

### Documentation Rules
- Write documentation in a professional but readable style.
- Explain business meaning, not only technical steps.
- README should be recruiter-friendly.
- Reports should sound like junior analyst work, not generic AI text.
- Avoid exaggerated claims.

### Scope Control
Do not add these unless specifically requested:

- Machine learning
- Forecasting
- Real APIs
- Web dashboard
- Authentication
- Cloud database setup
- Complex ETL pipelines
- Investment recommendations

---

## 21. Step-by-Step Build Plan

### Phase 1 — Project Setup
Create folder structure and initial README.

Files:
- README.md
- docs/data_dictionary.md
- docs/project_methodology.md

Goal:
Define the project clearly before writing SQL.

---

### Phase 2 — Dataset Design
Create realistic CSV files.

Files:
- data/customers.csv
- data/products.csv
- data/orders.csv
- data/order_items.csv
- data/monthly_targets.csv

Goal:
Have enough structured data to support meaningful SQL analysis.

---

### Phase 3 — Database Creation
Create SQL schema.

Files:
- sql/01_create_tables.sql
- sql/02_import_data.sql

Goal:
Set up relational tables with primary and foreign keys where possible.

---

### Phase 4 — Data Quality Checks
Create basic validation queries.

File:
- sql/03_data_quality_checks.sql

Goal:
Check if the dataset is reliable enough for analysis.

---

### Phase 5 — Financial Metrics View
Create reusable financial view.

File:
- sql/04_financial_metrics_views.sql

Goal:
Centralize revenue, cost, profit, and margin calculations.

---

### Phase 6 — Analysis Queries
Create business analysis queries.

File:
- sql/05_analysis_queries.sql

Goal:
Answer the main business questions using SQL.

---

### Phase 7 — Business Report
Write management-level findings.

Files:
- reports/business_insights.md
- reports/executive_summary.md

Goal:
Translate SQL outputs into business insights.

---

### Phase 8 — Portfolio Polish
Finalize README, screenshots, and CV summary.

Files:
- README.md
- screenshots/query_outputs/

Goal:
Make the project easy to understand for recruiters and hiring managers.

---

## 22. Definition of Done

The project is complete when:

- The repository has a clear folder structure.
- CSV data exists and is internally consistent.
- SQL table creation script runs successfully.
- Data can be imported successfully.
- Data quality checks are included.
- A reusable financial metrics view exists.
- Analysis queries answer the business questions.
- Business insights report is written.
- README explains the project clearly.
- CV bullet points are ready.
- Screenshots or sample outputs are included.

---

## 23. Quality Bar

This project should feel like a junior analyst case study.

It should not feel like:

- A random SQL tutorial
- A copied Kaggle notebook
- A purely technical database exercise
- A finance report without data logic
- An overengineered software project

The correct identity is:

> A finance-oriented SQL analysis project that turns business transaction data into clear management insights.

---

## 24. Future Improvements

After v1 is complete, possible extensions include:

1. Power BI dashboard using the same dataset
2. Python data validation script
3. Monthly automated reporting notebook
4. Customer cohort analysis
5. Product pricing sensitivity analysis
6. Forecasting monthly revenue
7. Adding operating expenses and net profit analysis
8. Building a simple Streamlit dashboard

Do not start these before the first version is complete.

---

## 25. Final Reminder for Claude Code

Always protect the project’s main purpose:

This project exists to help an Economics & Finance graduate demonstrate practical finance, SQL, data analysis, and business insight skills in a clean, professional, recruiter-friendly way.

Every file, query, and explanation should support that purpose.

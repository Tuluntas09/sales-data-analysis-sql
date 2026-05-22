# Executive Summary — SQL Financial Data Analysis

## Project Summary

This project performs a structured financial analysis on a retail company's transactional data using SQL. The analysis covers 706 completed orders, 150 customers, and 50 products across 6 categories for the fiscal year 2025.

The primary goal is to evaluate revenue performance, cost structure, gross profitability, customer segment value, regional trends, discount impact, and budget adherence — and to translate these findings into management-level insights.

---

## Business Questions Answered

1. Which products and categories generate the most revenue and profit?
2. Are high-revenue products also high-margin products?
3. Which customer segments are the most financially valuable?
4. Which regions perform strongly or weakly?
5. How do discounts affect profitability?
6. How does monthly performance trend throughout the year?
7. Is the company meeting its revenue and profit targets?
8. What actions should management consider?

---

## Key Metrics

| Metric | Value |
|---|---|
| Net Revenue | $143,723 |
| Total Cost (COGS) | $79,963 |
| Gross Profit | $63,760 |
| Gross Margin | 44.4% |
| Total Orders (Completed) | 706 |
| Average Order Value | $203.57 |
| Discount-to-Revenue Ratio | 4.5% |
| Budget Target Beat Rate | 3 of 12 months (25%) |

---

## Main Findings

**Revenue and Profitability**
- The company generated $143,723 in net revenue and $63,760 in gross profit at a 44.4% gross margin.
- Revenue follows a clear seasonal pattern with Q4 contributing 23.8% of annual revenue.

**Product and Category Mix**
- Electronics leads revenue (36.2% share) but has the lowest margin (27.8%). All 10 lowest-margin products are from Electronics.
- Beauty & Personal Care has the highest margin (74.0%) but the smallest revenue share (6.1%), suggesting untapped growth potential.
- The gap between revenue leadership and profit leadership is the most important structural finding.

**Customer Segments**
- Consumer is the volume driver (434 orders, $76,039 revenue).
- Corporate delivers the highest revenue per customer ($1,753) and highest AOV ($360) but receives the heaviest discounting (5.7%) and has the lowest margin (43.0%).
- Premium has the best margin (45.7%) and lowest discount rate (3.3%).

**Regional Performance**
- North leads in revenue (28.5% share). South trails at 12.4%.
- Regional margins are consistent (43.5%–44.9%), indicating a scale issue in weaker regions rather than a profitability problem.

**Discount Impact**
- Discounting stays within the 0–15% range. No items had discounts above 15%.
- Each discount tier costs approximately 2 percentage points of gross margin.
- The Medium (6–15%) band generates the most absolute revenue and profit.

**Budget Performance**
- The company missed revenue targets in 9 of 12 months.
- November (-8.3%) and February (-6.1%) had the largest misses.
- The consistent miss pattern suggests targets may be systematically over-budgeted.

---

## Management Recommendations

1. **Review Electronics margins** — Renegotiate supplier costs or adjust pricing on high-volume, low-margin items.
2. **Invest in high-margin categories** — Expand Beauty & Personal Care and Clothing product range to shift the overall margin mix upward.
3. **Reassess Corporate discount policy** — Ensure the 5.7% average discount rate is justified by incremental volume, not habitual pricing.
4. **Grow South region volume** — The margin is healthy; the opportunity is in scale and market penetration.
5. **Recalibrate budget targets** — A 75% miss rate indicates the target-setting process needs adjustment, particularly for Q4.
6. **Monitor moderate discounts** — The 6–15% band is productive but should be reviewed to prevent margin drift.

---

## Technical Skills Demonstrated

This project demonstrates the following capabilities:

- **Relational database design** — 5-table schema with primary keys, foreign keys, and check constraints
- **SQL querying** — CTEs, window functions (LAG, RANK, SUM OVER), CASE expressions, multi-table JOINs, aggregation
- **Financial metric calculation** — Gross revenue, net revenue, COGS, gross profit, gross margin, AOV, budget variance
- **Reusable SQL views** — Centralized financial calculations in views for consistent analysis
- **Data quality validation** — Systematic checks for nulls, duplicates, referential integrity, and value range violations
- **Business analysis** — Translating SQL outputs into structured management findings with actionable recommendations
- **Financial communication** — Clear distinction between revenue and profit, accurate use of margin, variance, and contribution metrics

---

## CV / Portfolio Value

This project is suitable for demonstrating practical skills in:

- Financial data analysis
- SQL proficiency (intermediate to advanced)
- Business reasoning and commercial awareness
- Structured analytical reporting
- Data quality discipline

**English CV bullet:**
Performed SQL-based financial data analysis on sales and cost datasets to evaluate revenue trends, gross margins, customer segments, regional performance, and budget variances; summarized insights in a management-level business report.

**Turkish CV bullet:**
SQL kullanarak satış ve finans verileri üzerinde gelir, maliyet, brüt kâr, kâr marjı, müşteri segmenti ve bölge bazlı performans analizi gerçekleştirdim. Sorgu sonuçlarını iş içgörülerine dönüştürerek kısa bir yönetim raporu hazırladım.

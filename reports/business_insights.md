# SQL Financial Analysis — Business Insights Report

## 1. Executive Summary

This report summarizes the financial performance of the company for the fiscal year 2025, based on SQL analysis of 706 completed orders across 150 customers and 50 products in 6 categories.

The company generated **$143,723 in net revenue** and **$63,760 in gross profit**, achieving an overall gross margin of **44.4%**. Average order value stood at **$203.57**.

Key findings indicate that Electronics dominates revenue contribution at 36.2% but carries the lowest category margin at 27.8%. Conversely, Beauty & Personal Care delivers the highest margin at 74.0% but accounts for only 6.1% of revenue. The company met its monthly revenue targets in only 3 out of 12 months, suggesting a need to revisit budget assumptions or commercial strategy.

---

## 2. Revenue Performance

| Metric | Value |
|---|---|
| Gross Revenue | $150,428 |
| Total Discount Amount | $6,705 |
| Net Revenue | $143,723 |
| Total Cost (COGS) | $79,963 |
| Discount-to-Gross Revenue Ratio | 4.5% |
| Average Order Value | $203.57 |

The discount-to-gross revenue ratio of 4.5% indicates a moderate discounting strategy overall. Of $150,428 in gross revenue, approximately $6,705 was given away through discounts before arriving at net revenue of $143,723.

The average order value of $203.57 reflects a mid-range transaction size consistent with a mixed retail portfolio spanning electronics to personal care products.

---

## 3. Profitability Performance

| Metric | Value |
|---|---|
| Net Revenue | $143,723 |
| Total Cost (COGS) | $79,963 |
| Gross Profit | $63,760 |
| Gross Margin | 44.4% |

The company retains 44.4 cents of every dollar of net revenue after product cost. This margin is reasonable for a multi-category retailer, though the aggregate figure masks significant variation across categories (ranging from 27.8% to 74.0%).

It is important to note that this analysis covers gross profit only. Operating expenses, taxes, shipping costs, and payment processing fees are not included. Actual net profitability would be lower.

---

## 4. Monthly Trend Analysis

| Month | Orders | Net Revenue | Gross Profit | Gross Margin | MoM Growth |
|---|---|---|---|---|---|
| Jan | 48 | $8,882 | $3,996 | 45.0% | — |
| Feb | 44 | $8,359 | $3,833 | 45.9% | -5.9% |
| Mar | 50 | $9,838 | $4,489 | 45.6% | +17.7% |
| Apr | 55 | $11,494 | $4,986 | 43.4% | +16.8% |
| May | 57 | $12,880 | $5,557 | 43.1% | +12.1% |
| Jun | 63 | $11,313 | $5,106 | 45.1% | -12.2% |
| Jul | 55 | $10,963 | $4,929 | 45.0% | -3.1% |
| Aug | 55 | $12,540 | $5,376 | 42.9% | +14.4% |
| Sep | 60 | $12,058 | $5,548 | 46.0% | -3.8% |
| Oct | 64 | $11,145 | $4,864 | 43.6% | -7.6% |
| Nov | 76 | $16,774 | $7,583 | 45.2% | +50.5% |
| Dec | 79 | $17,476 | $7,492 | 42.9% | +4.2% |

**Key observations:**

- Revenue follows a seasonal pattern: Q1 is the weakest period, with a gradual build through Q2–Q3 and a strong Q4 surge.
- November and December represent the peak months, contributing a combined $34,250 in net revenue (23.8% of annual total). The November MoM growth of +50.5% reflects the holiday season effect.
- Gross margin remains relatively stable between 42.9% and 46.0%, suggesting consistent pricing and cost structure throughout the year.
- The mid-year dip in June (-12.2% MoM) and October (-7.6% MoM) may warrant further investigation to understand whether these are demand-driven or operational.

---

## 5. Product-Level Insights

### Top 5 Products by Net Revenue

| Product | Category | Net Revenue | Gross Profit | Margin |
|---|---|---|---|---|
| 27-inch Monitor Full HD | Electronics | $12,999 | $3,279 | 25.2% |
| Standing Desk Converter | Office Supplies | $9,596 | $3,996 | 41.6% |
| Noise Cancelling Earbuds | Electronics | $6,931 | $1,981 | 28.6% |
| Smart Watch Basic | Electronics | $6,769 | $1,634 | 24.1% |
| Document Shredder Compact | Office Supplies | $5,902 | $2,332 | 39.5% |

### Lowest Margin Products (with revenue > $1,000)

| Product | Category | Margin | Net Revenue |
|---|---|---|---|
| Smart Watch Basic | Electronics | 24.1% | $6,769 |
| 27-inch Monitor Full HD | Electronics | 25.2% | $12,999 |
| Wireless Bluetooth Headphones | Electronics | 25.3% | $4,590 |
| Wireless Keyboard and Mouse Set | Electronics | 26.3% | $3,116 |
| External SSD 500GB | Electronics | 27.2% | $5,825 |

**Key observations:**

- The top revenue product (27-inch Monitor Full HD) generates nearly $13,000 in revenue but operates at only 25.2% margin — well below the company average of 44.4%.
- All 10 lowest-margin products above $1,000 revenue are from the Electronics category. This is a structural characteristic of the category, not an anomaly.
- The Standing Desk Converter is a notable performer: second in revenue and delivering a healthier 41.6% margin.
- High revenue does not equal high profitability. The analysis results indicate that the company's revenue leaders are not its margin leaders.

---

## 6. Category-Level Insights

| Category | Net Revenue | Revenue Share | Gross Profit | Profit Share | Margin |
|---|---|---|---|---|---|
| Electronics | $51,976 | 36.2% | $14,462 | 22.7% | 27.8% |
| Clothing | $23,620 | 16.4% | $13,854 | 21.7% | 58.7% |
| Sports & Outdoor | $23,428 | 16.3% | $11,634 | 18.2% | 49.7% |
| Office Supplies | $19,237 | 13.4% | $8,536 | 13.4% | 44.4% |
| Home & Kitchen | $16,731 | 11.6% | $8,811 | 13.8% | 52.7% |
| Beauty & Personal Care | $8,731 | 6.1% | $6,464 | 10.1% | 74.0% |

**Key observations:**

- **Electronics** is the revenue leader (36.2%) but contributes disproportionately less to profit (22.7%) due to its 27.8% margin. It generates nearly half the revenue of the company but less than a quarter of its profit.
- **Clothing** generates 16.4% of revenue but delivers 21.7% of profit, making it a margin-efficient category at 58.7%.
- **Beauty & Personal Care** has the highest margin at 74.0% and contributes 10.1% of profit despite only 6.1% revenue share. This category may represent a growth opportunity if volume can be increased without compressing margins.
- **Office Supplies** at 44.4% margin aligns exactly with the company average — a stable, balanced category.
- The gap between Electronics' revenue share (36.2%) and profit share (22.7%) is the most significant category-level finding. Revenue concentration in a low-margin category creates risk.

---

## 7. Customer Segment Insights

| Segment | Customers | Orders | Net Revenue | Gross Profit | Margin | AOV |
|---|---|---|---|---|---|---|
| Consumer | 93 | 434 | $76,039 | $34,061 | 44.8% | $175 |
| Corporate | 23 | 112 | $40,327 | $17,321 | 43.0% | $360 |
| Small Business | 21 | 103 | $18,038 | $8,120 | 45.0% | $175 |
| Premium | 11 | 57 | $9,319 | $4,258 | 45.7% | $163 |

| Segment | Avg Discount Rate | Revenue per Customer |
|---|---|---|
| Corporate | 5.7% | $1,753 |
| Small Business | 4.6% | $859 |
| Consumer | 3.7% | $818 |
| Premium | 3.3% | $847 |

**Key observations:**

- **Consumer** is the largest segment by volume (434 orders, $76,039 revenue) and maintains a healthy 44.8% margin. It is the revenue backbone.
- **Corporate** generates the highest revenue per customer ($1,753) and highest AOV ($360) but carries the highest discount rate (5.7%) and the lowest margin (43.0%). The high volume per customer comes at a discounting cost.
- **Premium** has the highest margin at 45.7% and lowest discount rate at 3.3%, but is the smallest segment with only 11 active customers and $163 AOV. The results suggest that Premium customers are not necessarily spending more per order, but they retain more value per transaction.
- **Small Business** sits in the middle: moderate margins (45.0%), moderate discounting (4.6%), but lower revenue per customer ($859) than Corporate.

---

## 8. Regional Performance

| Region | Customers | Orders | Net Revenue | Revenue Share | Gross Profit | Margin | AOV |
|---|---|---|---|---|---|---|---|
| North | 40 | 207 | $40,921 | 28.5% | $18,160 | 44.4% | $198 |
| East | 26 | 120 | $29,454 | 20.5% | $12,823 | 43.5% | $245 |
| West | 29 | 145 | $28,618 | 19.9% | $12,843 | 44.9% | $197 |
| Central | 28 | 140 | $26,935 | 18.7% | $12,072 | 44.8% | $192 |
| South | 25 | 94 | $17,795 | 12.4% | $7,862 | 44.2% | $189 |

**Key observations:**

- **North** leads in revenue ($40,921, 28.5% share) and order volume (207 orders), matching the company average margin at 44.4%.
- **East** has the highest AOV ($245), suggesting higher-value transactions, but a slightly below-average margin at 43.5%.
- **South** is the weakest region in both revenue ($17,795, 12.4% share) and order volume (94 orders). Margin is close to average at 44.2%, so the issue is primarily scale, not profitability.
- Regional margins are relatively tight (43.5%–44.9%), indicating consistent pricing and product mix across geographies. No region shows a dramatic margin problem.
- The primary regional difference is in scale and penetration, not profitability. Growth efforts might focus on increasing South region volume.

---

## 9. Discount Impact

### Performance by Discount Band

| Discount Band | Items | Net Revenue | Gross Profit | Margin | Avg Rate |
|---|---|---|---|---|---|
| No Discount (0%) | 565 | $47,017 | $21,707 | 46.2% | 0.0% |
| Low (1–5%) | 594 | $39,004 | $17,719 | 45.4% | 3.4% |
| Medium (6–15%) | 700 | $57,702 | $24,334 | 42.2% | 8.2% |
| High (16–25%) | 0 | $0 | $0 | — | — |

**Key observations:**

- The High Discount band (16–25%) contains zero order items. The actual discount distribution stays within the 0–15% range, indicating conservative discount practices.
- There is a clear margin erosion as discount rates increase: from 46.2% (no discount) to 45.4% (low) to 42.2% (medium). Each discount tier costs approximately 2 percentage points of margin.
- The Medium Discount band generates the most revenue ($57,702) and the most profit ($24,334), suggesting that moderate discounting is effective at driving volume while maintaining acceptable margins.
- Non-discounted sales represent 30.4% of order items but 32.7% of net revenue, showing that full-price sales tend to be slightly higher-value transactions.

### Discount by Category

| Category | Avg Discount | Margin |
|---|---|---|
| Clothing | 7.0% | 58.7% |
| Corporate Discount Rate | 5.7% | 43.0% |
| Electronics | 4.5% | 27.8% |
| Sports & Outdoor | 3.8% | 49.7% |
| Home & Kitchen | 3.3% | 52.7% |
| Office Supplies | 3.2% | 44.4% |
| Beauty & Personal Care | 2.5% | 74.0% |

Clothing has the highest average discount (7.0%) but still maintains a strong margin at 58.7%. Electronics discounting at 4.5% on an already-low 27.8% margin is more concerning — every discount point matters more when the base margin is thin.

---

## 10. Budget vs Actual

| Month | Actual Revenue | Target | Variance | Var % | Status |
|---|---|---|---|---|---|
| Jan | $8,882 | $9,100 | -$218 | -2.4% | Miss |
| Feb | $8,359 | $8,900 | -$541 | -6.1% | Miss |
| Mar | $9,838 | $10,200 | -$362 | -3.5% | Miss |
| Apr | $11,494 | $11,700 | -$206 | -1.8% | Miss |
| May | $12,880 | $12,800 | +$80 | +0.6% | Beat |
| Jun | $11,313 | $11,500 | -$187 | -1.6% | Miss |
| Jul | $10,963 | $10,700 | +$263 | +2.5% | Beat |
| Aug | $12,540 | $12,600 | -$60 | -0.5% | Miss |
| Sep | $12,058 | $11,500 | +$558 | +4.9% | Beat |
| Oct | $11,145 | $11,700 | -$555 | -4.7% | Miss |
| Nov | $16,774 | $18,300 | -$1,526 | -8.3% | Miss |
| Dec | $17,476 | $18,500 | -$1,024 | -5.5% | Miss |

**Beat months: 3 | Miss months: 9**

**Key observations:**

- The company missed revenue targets in 9 out of 12 months, achieving targets only in May (+0.6%), July (+2.5%), and September (+4.9%).
- November had the worst variance (-8.3%, -$1,526). Despite strong seasonal revenue growth, the target was set even higher and was not met. This indicates Q4 targets may have been overly ambitious.
- The closest misses were in August (-0.5%) and April (-1.8%), suggesting these months were nearly on target.
- The pattern suggests that targets may have been set with an optimistic bias throughout the year, particularly in Q4 where the largest absolute misses occurred.
- Management should review the target-setting methodology: a consistent miss pattern may indicate systematic over-budgeting rather than underperformance.

---

## 11. Order Status and Cancellation Notes

| Status | Orders | Share | Gross Revenue |
|---|---|---|---|
| Completed | 706 | 88.3% | $150,428 |
| Cancelled | 64 | 8.0% | $13,308 |
| Refunded | 30 | 3.8% | $8,914 |

Cancelled and refunded orders represent approximately $21,097 in potential net revenue that was not realized. This amounts to 12.8% of total order value.

These orders are excluded from all standard financial metrics in this report. They are noted here for operational context only. A cancellation rate of 8.0% and refund rate of 3.8% may warrant separate operational investigation if these rates are above industry benchmarks.

---

## 12. Management Recommendations

Based on the analysis results, the following actions are recommended:

1. **Review Electronics pricing and cost structure.** Electronics contributes 36.2% of revenue but only 22.7% of profit due to a 27.8% margin. Negotiate better supplier terms or evaluate whether selective price adjustments are possible on high-volume items (e.g., 27-inch Monitor at 25.2% margin, Smart Watch at 24.1%).

2. **Explore growth potential in high-margin categories.** Beauty & Personal Care (74.0% margin) and Clothing (58.7% margin) are significantly above the company average. Increasing marketing spend or product range in these categories could improve the overall margin mix without requiring revenue growth in lower-margin areas.

3. **Reassess the discount policy for Corporate customers.** The Corporate segment receives the highest average discount (5.7%) and has the lowest margin (43.0%). While Corporate delivers the highest revenue per customer ($1,753), the discount cost should be weighed against the incremental volume it generates.

4. **Investigate South region scale.** South accounts for only 12.4% of revenue despite having 25 customers. The margin (44.2%) is not the issue — the opportunity is in increasing order volume and customer acquisition in this region.

5. **Revise the budget target-setting process.** A 9-out-of-12 miss rate suggests targets are systematically too high. Q4 targets in particular were $2,550 above actual performance combined. More conservative initial targets with stretch goals would provide more actionable budget comparisons.

6. **Monitor the moderate-discount band carefully.** The Medium (6–15%) discount band generates the most revenue and profit but at a 4-point margin gap versus non-discounted sales. Ensure that discount approvals in this range are driving genuinely incremental volume rather than discounting sales that would have happened at full price.

---

## 13. Limitations

- This analysis uses a realistic synthetic dataset, not actual company data. Data patterns are designed to reflect common retail business dynamics but do not represent any real organization.
- The analysis covers **gross profit only**. Operating expenses, salaries, rent, marketing spend, taxes, shipping costs, and payment processing fees are not included. Actual net profitability would be lower.
- The time period is limited to January–December 2025 (12 months). Year-over-year comparisons are not possible.
- Budget targets are set at company level. No regional, category, or segment-level targets exist for more granular variance analysis.
- Customer lifetime value, retention, and churn are not analyzed in this version.
- This is a static SQL-based analysis, not a live reporting system.

---

## 14. Next Steps

Potential extensions for future analysis:

1. **Power BI Dashboard** — Visualize monthly trends, category performance, and regional comparisons interactively.
2. **Operating Expense Layer** — Add OPEX data to calculate net profit and contribution margin by category.
3. **Customer Cohort Analysis** — Analyze retention and repeat purchase behavior by signup month.
4. **Real-World Dataset Extension** — Apply the same analytical framework to a public dataset (e.g., UCI Online Retail) for additional portfolio value.
5. **Automated Monthly Reporting** — Build a scheduled SQL reporting pipeline for ongoing performance monitoring.

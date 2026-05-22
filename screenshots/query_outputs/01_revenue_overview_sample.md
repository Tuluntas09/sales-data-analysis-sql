# Sample Output — Revenue Overview

**Source:** `sql/05_analysis_queries.sql` — Section 1, Query 1.1

## Query: Total Financial Overview

```
 total_orders | total_quantity_sold | gross_revenue | discount_amount | net_revenue  | total_cost | gross_profit | gross_margin |  aov
--------------+--------------------+---------------+-----------------+--------------+------------+--------------+--------------+--------
          706 |               4393 |     150428.11 |         6705.37 |    143722.91 |   79963.00 |     63759.91 |       0.4436 | 203.57
```

## Interpretation

- The company processed **706 completed orders** selling **4,393 units** during 2025.
- **Gross revenue** of $150,428 was reduced by **$6,705 in discounts** (4.5% of gross revenue), resulting in **$143,723 net revenue**.
- After deducting **$79,963 in cost of goods sold**, the company earned **$63,760 in gross profit**.
- The overall **gross margin is 44.4%**, meaning the company retains roughly 44 cents of profit for every dollar of net revenue.
- **Average order value** stands at $203.57 per completed order.

---

*Query output from `vw_completed_order_financials` view. Only Completed orders are included.*

# Sample Output — Budget vs Actual

**Source:** `sql/05_analysis_queries.sql` — Section 8, Query 8.1

## Query: Monthly Actual vs Target with Variance

```
 order_month | actual_revenue | target_revenue | revenue_variance | revenue_variance_pct | actual_gross_profit | target_gross_profit | profit_variance | profit_variance_pct | performance_status
-------------+----------------+----------------+------------------+----------------------+---------------------+---------------------+-----------------+---------------------+--------------------
 2025-01-01  |        8881.63 |        9100.00 |          -218.37 |              -0.0240 |             3995.63 |             4200.00 |         -204.37 |             -0.0487 | Miss
 2025-02-01  |        8359.20 |        8900.00 |          -540.80 |              -0.0608 |             3833.20 |             4000.00 |         -166.80 |             -0.0417 | Miss
 2025-03-01  |        9838.09 |       10200.00 |          -361.91 |              -0.0355 |             4488.59 |             4700.00 |         -211.41 |             -0.0450 | Miss
 2025-04-01  |       11493.76 |       11700.00 |          -206.24 |              -0.0176 |             4986.26 |             5500.00 |         -513.74 |             -0.0934 | Miss
 2025-05-01  |       12879.89 |       12800.00 |            79.89 |               0.0062 |             5557.39 |             5600.00 |          -42.61 |             -0.0076 | Beat
 2025-06-01  |       11312.89 |       11500.00 |          -187.11 |              -0.0163 |             5106.39 |             5000.00 |          106.39 |              0.0213 | Miss
 2025-07-01  |       10963.14 |       10700.00 |           263.14 |               0.0246 |             4929.14 |             4700.00 |          229.14 |              0.0488 | Beat
 2025-08-01  |       12539.96 |       12600.00 |           -60.04 |              -0.0048 |             5375.96 |             5500.00 |         -124.04 |             -0.0226 | Miss
 2025-09-01  |       12058.26 |       11500.00 |           558.26 |               0.0486 |             5547.76 |             5500.00 |           47.76 |              0.0087 | Beat
 2025-10-01  |       11145.35 |       11700.00 |          -554.65 |              -0.0474 |             4864.35 |             4900.00 |          -35.65 |             -0.0073 | Miss
 2025-11-01  |       16774.38 |       18300.00 |         -1525.62 |              -0.0834 |             7583.38 |             7700.00 |         -116.62 |             -0.0151 | Miss
 2025-12-01  |       17476.36 |       18500.00 |         -1023.64 |              -0.0553 |             7491.86 |             8200.00 |         -708.14 |             -0.0864 | Miss
```

## Query: Beat vs Miss Summary

```
 beat_months | miss_months
-------------+-------------
           3 |           9
```

## Interpretation

- The company **exceeded revenue targets in only 3 months** (May, July, September) and missed in the remaining 9 months.
- **November** had the largest absolute miss: $1,526 below target (-8.3%). Despite strong seasonal revenue growth (+50.5% MoM), the Q4 target was set even higher.
- **September** was the best performer: +4.9% above target ($558 surplus).
- **August** was the closest miss: only $60 below target (-0.5%).
- The consistent miss pattern across most months suggests that the annual budget may have been set with an optimistic bias. Management should review the target-setting methodology, particularly for Q4 where the largest absolute misses occurred ($1,526 + $1,024 = $2,550 combined).

---

*Query output from `vw_completed_order_financials` joined with `monthly_targets`. Only Completed orders are included in actuals.*

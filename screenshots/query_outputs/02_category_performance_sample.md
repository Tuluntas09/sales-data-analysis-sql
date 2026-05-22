# Sample Output — Category Performance

**Source:** `sql/05_analysis_queries.sql` — Section 4, Query 4.2

## Query: Category Contribution to Total Revenue and Profit

```
        category         | net_revenue | revenue_share_pct | gross_profit | profit_share_pct
-------------------------+-------------+-------------------+--------------+------------------
 Electronics              |    51975.73 |              36.2 |     14462.23 |             22.7
 Clothing                 |    23620.19 |              16.4 |     13853.69 |             21.7
 Sports & Outdoor         |    23427.94 |              16.3 |     11633.94 |             18.2
 Office Supplies          |    19237.22 |              13.4 |      8535.72 |             13.4
 Home & Kitchen           |    16730.74 |              11.6 |      8810.74 |             13.8
 Beauty & Personal Care   |     8731.09 |               6.1 |      6463.59 |             10.1
```

## Query: Category Margin Ranking

```
        category         | gross_margin | net_revenue | margin_rank
-------------------------+--------------+-------------+-------------
 Beauty & Personal Care   |       0.7400 |     8731.09 |           1
 Clothing                 |       0.5870 |    23620.19 |           2
 Home & Kitchen           |       0.5270 |    16730.74 |           3
 Sports & Outdoor         |       0.4970 |    23427.94 |           4
 Office Supplies          |       0.4440 |    19237.22 |           5
 Electronics              |       0.2780 |    51975.73 |           6
```

## Interpretation

- **Electronics** dominates revenue with a 36.2% share but contributes only 22.7% of gross profit. This 13.5 percentage point gap between revenue share and profit share is the most significant category-level finding.
- **Clothing** punches above its weight: 16.4% of revenue but 21.7% of profit, thanks to a strong 58.7% margin.
- **Beauty & Personal Care** achieves 74.0% gross margin — the highest by a wide margin — but represents only 6.1% of revenue. This category is a candidate for volume growth.
- **Office Supplies** is the most balanced category: its revenue share (13.4%) and profit share (13.4%) are identical, reflecting a margin exactly at the company average.

---

*Query output from `vw_completed_order_financials` view. Only Completed orders are included.*

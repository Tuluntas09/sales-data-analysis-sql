-- ============================================================
-- 05_analysis_queries.sql
-- SQL Financial Data Analysis — Core Analysis Queries
-- ============================================================
-- This file contains the main financial analysis queries
-- organized into 10 business-focused sections.
--
-- Primary view: vw_completed_order_financials
--   Contains only Completed orders for standard financial analysis.
--
-- Secondary view: vw_order_item_financials
--   Contains all order statuses; used for cancellation/refund analysis.
--
-- All queries are read-only (SELECT only). No data is modified.
-- ============================================================


-- ============================================================
-- SECTION 1 — REVENUE OVERVIEW
-- Business question: What is the company's overall financial
-- position for 2025?
-- ============================================================

-- 1.1 Total financial overview
-- Provides the executive-level summary of all key financial metrics.
SELECT
    COUNT(DISTINCT order_id)   AS total_orders,
    SUM(quantity)              AS total_quantity_sold,
    ROUND(SUM(gross_revenue), 2)   AS gross_revenue,
    ROUND(SUM(discount_amount), 2) AS discount_amount,
    ROUND(SUM(net_revenue), 2)     AS net_revenue,
    ROUND(SUM(total_cost), 2)      AS total_cost,
    ROUND(SUM(gross_profit), 2)    AS gross_profit,
    CASE
        WHEN SUM(net_revenue) = 0 THEN NULL
        ELSE ROUND(SUM(gross_profit) / SUM(net_revenue), 4)
    END AS gross_margin,
    ROUND(SUM(net_revenue) / NULLIF(COUNT(DISTINCT order_id), 0), 2)
        AS average_order_value
FROM vw_completed_order_financials;


-- 1.2 Revenue and profit contribution summary
-- Shows how much of gross revenue is lost to discounts and cost.
SELECT
    ROUND(SUM(net_revenue), 2)     AS net_revenue,
    ROUND(SUM(gross_profit), 2)    AS gross_profit,
    ROUND(SUM(discount_amount), 2) AS total_discount_amount,
    CASE
        WHEN SUM(gross_revenue) = 0 THEN NULL
        ELSE ROUND(SUM(discount_amount) / SUM(gross_revenue), 4)
    END AS discount_to_gross_revenue_ratio
FROM vw_completed_order_financials;


-- ============================================================
-- SECTION 2 — MONTHLY TREND ANALYSIS
-- Business question: Is the company's performance improving,
-- declining, or volatile over time?
-- ============================================================

-- 2.1 Monthly revenue, cost, gross profit, and gross margin
SELECT
    order_month,
    COUNT(DISTINCT order_id) AS order_count,
    ROUND(SUM(net_revenue), 2)  AS net_revenue,
    ROUND(SUM(total_cost), 2)   AS total_cost,
    ROUND(SUM(gross_profit), 2) AS gross_profit,
    CASE
        WHEN SUM(net_revenue) = 0 THEN NULL
        ELSE ROUND(SUM(gross_profit) / SUM(net_revenue), 4)
    END AS gross_margin
FROM vw_completed_order_financials
GROUP BY order_month
ORDER BY order_month;


-- 2.2 Month-over-month revenue growth
-- Uses LAG window function to compare each month with the previous.
WITH monthly AS (
    SELECT
        order_month,
        ROUND(SUM(net_revenue), 2) AS net_revenue
    FROM vw_completed_order_financials
    GROUP BY order_month
)
SELECT
    order_month,
    net_revenue,
    LAG(net_revenue) OVER (ORDER BY order_month) AS previous_month_revenue,
    ROUND(net_revenue - LAG(net_revenue) OVER (ORDER BY order_month), 2)
        AS revenue_change,
    CASE
        WHEN LAG(net_revenue) OVER (ORDER BY order_month) = 0 THEN NULL
        ELSE ROUND(
            (net_revenue - LAG(net_revenue) OVER (ORDER BY order_month))
            / LAG(net_revenue) OVER (ORDER BY order_month), 4)
    END AS revenue_growth_pct
FROM monthly
ORDER BY order_month;


-- 2.3 Monthly discount trend
-- Tracks how discount intensity changes over the year.
SELECT
    order_month,
    ROUND(SUM(gross_revenue), 2)   AS gross_revenue,
    ROUND(SUM(discount_amount), 2) AS discount_amount,
    CASE
        WHEN SUM(gross_revenue) = 0 THEN NULL
        ELSE ROUND(SUM(discount_amount) / SUM(gross_revenue), 4)
    END AS discount_rate_effective
FROM vw_completed_order_financials
GROUP BY order_month
ORDER BY order_month;


-- ============================================================
-- SECTION 3 — PRODUCT-LEVEL PROFITABILITY
-- Business question: Which products create the most value,
-- and are high-revenue products also high-margin products?
-- ============================================================

-- 3.1 Top 10 products by net revenue
SELECT
    product_id,
    product_name,
    category,
    ROUND(SUM(net_revenue), 2)  AS net_revenue,
    ROUND(SUM(gross_profit), 2) AS gross_profit,
    CASE
        WHEN SUM(net_revenue) = 0 THEN NULL
        ELSE ROUND(SUM(gross_profit) / SUM(net_revenue), 4)
    END AS gross_margin,
    SUM(quantity) AS quantity_sold
FROM vw_completed_order_financials
GROUP BY product_id, product_name, category
ORDER BY net_revenue DESC
LIMIT 10;


-- 3.2 Top 10 products by gross profit
SELECT
    product_id,
    product_name,
    category,
    ROUND(SUM(gross_profit), 2) AS gross_profit,
    ROUND(SUM(net_revenue), 2)  AS net_revenue,
    CASE
        WHEN SUM(net_revenue) = 0 THEN NULL
        ELSE ROUND(SUM(gross_profit) / SUM(net_revenue), 4)
    END AS gross_margin,
    SUM(quantity) AS quantity_sold
FROM vw_completed_order_financials
GROUP BY product_id, product_name, category
ORDER BY gross_profit DESC
LIMIT 10;


-- 3.3 Top 10 products by quantity sold
SELECT
    product_id,
    product_name,
    category,
    SUM(quantity) AS quantity_sold,
    ROUND(SUM(net_revenue), 2)  AS net_revenue,
    ROUND(SUM(gross_profit), 2) AS gross_profit,
    CASE
        WHEN SUM(net_revenue) = 0 THEN NULL
        ELSE ROUND(SUM(gross_profit) / SUM(net_revenue), 4)
    END AS gross_margin
FROM vw_completed_order_financials
GROUP BY product_id, product_name, category
ORDER BY quantity_sold DESC
LIMIT 10;


-- 3.4 Lowest 10 products by gross margin
-- Filtered to products with meaningful revenue (> 1000) to
-- avoid misleading margins on low-volume items.
SELECT
    product_id,
    product_name,
    category,
    CASE
        WHEN SUM(net_revenue) = 0 THEN NULL
        ELSE ROUND(SUM(gross_profit) / SUM(net_revenue), 4)
    END AS gross_margin,
    ROUND(SUM(net_revenue), 2)  AS net_revenue,
    ROUND(SUM(gross_profit), 2) AS gross_profit,
    SUM(quantity) AS quantity_sold
FROM vw_completed_order_financials
GROUP BY product_id, product_name, category
HAVING SUM(net_revenue) > 1000
ORDER BY gross_margin ASC
LIMIT 10;


-- 3.5 High revenue but low margin products
-- Products in the top revenue quartile with gross margin
-- below the company average. These may need pricing review.
WITH company_avg AS (
    SELECT
        CASE
            WHEN SUM(net_revenue) = 0 THEN NULL
            ELSE SUM(gross_profit) / SUM(net_revenue)
        END AS avg_gross_margin
    FROM vw_completed_order_financials
),
product_metrics AS (
    SELECT
        product_id,
        product_name,
        category,
        ROUND(SUM(net_revenue), 2)  AS net_revenue,
        ROUND(SUM(gross_profit), 2) AS gross_profit,
        CASE
            WHEN SUM(net_revenue) = 0 THEN NULL
            ELSE ROUND(SUM(gross_profit) / SUM(net_revenue), 4)
        END AS gross_margin
    FROM vw_completed_order_financials
    GROUP BY product_id, product_name, category
)
SELECT
    pm.product_id,
    pm.product_name,
    pm.category,
    pm.net_revenue,
    pm.gross_profit,
    pm.gross_margin,
    ROUND(ca.avg_gross_margin, 4) AS company_avg_margin
FROM product_metrics pm
CROSS JOIN company_avg ca
WHERE pm.gross_margin < ca.avg_gross_margin
ORDER BY pm.net_revenue DESC
LIMIT 10;


-- ============================================================
-- SECTION 4 — CATEGORY-LEVEL ANALYSIS
-- Business question: Which product categories drive revenue
-- and which drive margin?
-- ============================================================

-- 4.1 Category performance overview
SELECT
    category,
    ROUND(SUM(net_revenue), 2)  AS net_revenue,
    ROUND(SUM(gross_profit), 2) AS gross_profit,
    CASE
        WHEN SUM(net_revenue) = 0 THEN NULL
        ELSE ROUND(SUM(gross_profit) / SUM(net_revenue), 4)
    END AS gross_margin,
    SUM(quantity)                AS quantity_sold,
    COUNT(DISTINCT order_id)     AS order_count
FROM vw_completed_order_financials
GROUP BY category
ORDER BY net_revenue DESC;


-- 4.2 Category contribution to total revenue and profit
WITH totals AS (
    SELECT
        SUM(net_revenue)  AS total_revenue,
        SUM(gross_profit) AS total_profit
    FROM vw_completed_order_financials
)
SELECT
    v.category,
    ROUND(SUM(v.net_revenue), 2)  AS net_revenue,
    ROUND(SUM(v.net_revenue) / NULLIF(t.total_revenue, 0) * 100, 1)
        AS revenue_share_pct,
    ROUND(SUM(v.gross_profit), 2) AS gross_profit,
    ROUND(SUM(v.gross_profit) / NULLIF(t.total_profit, 0) * 100, 1)
        AS profit_share_pct
FROM vw_completed_order_financials v
CROSS JOIN totals t
GROUP BY v.category, t.total_revenue, t.total_profit
ORDER BY net_revenue DESC;


-- 4.3 Category margin ranking
SELECT
    category,
    CASE
        WHEN SUM(net_revenue) = 0 THEN NULL
        ELSE ROUND(SUM(gross_profit) / SUM(net_revenue), 4)
    END AS gross_margin,
    ROUND(SUM(net_revenue), 2) AS net_revenue,
    RANK() OVER (
        ORDER BY CASE
            WHEN SUM(net_revenue) = 0 THEN NULL
            ELSE SUM(gross_profit) / SUM(net_revenue)
        END DESC
    ) AS margin_rank
FROM vw_completed_order_financials
GROUP BY category
ORDER BY gross_margin DESC;


-- ============================================================
-- SECTION 5 — CUSTOMER SEGMENT ANALYSIS
-- Business question: Which customer segments are the most
-- valuable in terms of revenue, profit, and buying behavior?
-- ============================================================

-- 5.1 Segment performance overview
SELECT
    segment,
    COUNT(DISTINCT customer_id)  AS customer_count,
    COUNT(DISTINCT order_id)     AS order_count,
    ROUND(SUM(net_revenue), 2)   AS net_revenue,
    ROUND(SUM(gross_profit), 2)  AS gross_profit,
    CASE
        WHEN SUM(net_revenue) = 0 THEN NULL
        ELSE ROUND(SUM(gross_profit) / SUM(net_revenue), 4)
    END AS gross_margin,
    ROUND(SUM(net_revenue) / NULLIF(COUNT(DISTINCT order_id), 0), 2)
        AS average_order_value
FROM vw_completed_order_financials
GROUP BY segment
ORDER BY net_revenue DESC;


-- 5.2 Revenue and profit per customer by segment
SELECT
    segment,
    COUNT(DISTINCT customer_id) AS customer_count,
    ROUND(SUM(net_revenue) / NULLIF(COUNT(DISTINCT customer_id), 0), 2)
        AS revenue_per_customer,
    ROUND(SUM(gross_profit) / NULLIF(COUNT(DISTINCT customer_id), 0), 2)
        AS profit_per_customer
FROM vw_completed_order_financials
GROUP BY segment
ORDER BY revenue_per_customer DESC;


-- 5.3 Segment discount behavior
-- Shows how discount-intensive each segment is and whether
-- heavy discounting correlates with lower margins.
SELECT
    segment,
    ROUND(AVG(discount_rate), 4)       AS avg_discount_rate,
    ROUND(SUM(discount_amount), 2)     AS total_discount_amount,
    CASE
        WHEN SUM(gross_revenue) = 0 THEN NULL
        ELSE ROUND(SUM(discount_amount) / SUM(gross_revenue), 4)
    END AS discount_to_gross_revenue_ratio
FROM vw_completed_order_financials
GROUP BY segment
ORDER BY avg_discount_rate DESC;


-- ============================================================
-- SECTION 6 — REGIONAL PERFORMANCE ANALYSIS
-- Business question: Which regions are strong or weak in
-- revenue and profitability?
-- ============================================================

-- 6.1 Region performance overview
SELECT
    region,
    COUNT(DISTINCT customer_id)  AS customer_count,
    COUNT(DISTINCT order_id)     AS order_count,
    ROUND(SUM(net_revenue), 2)   AS net_revenue,
    ROUND(SUM(gross_profit), 2)  AS gross_profit,
    CASE
        WHEN SUM(net_revenue) = 0 THEN NULL
        ELSE ROUND(SUM(gross_profit) / SUM(net_revenue), 4)
    END AS gross_margin,
    ROUND(SUM(net_revenue) / NULLIF(COUNT(DISTINCT order_id), 0), 2)
        AS average_order_value
FROM vw_completed_order_financials
GROUP BY region
ORDER BY net_revenue DESC;


-- 6.2 Region contribution to total revenue and profit
WITH totals AS (
    SELECT
        SUM(net_revenue)  AS total_revenue,
        SUM(gross_profit) AS total_profit
    FROM vw_completed_order_financials
)
SELECT
    v.region,
    ROUND(SUM(v.net_revenue), 2) AS net_revenue,
    ROUND(SUM(v.net_revenue) / NULLIF(t.total_revenue, 0) * 100, 1)
        AS revenue_share_pct,
    ROUND(SUM(v.gross_profit), 2) AS gross_profit,
    ROUND(SUM(v.gross_profit) / NULLIF(t.total_profit, 0) * 100, 1)
        AS profit_share_pct
FROM vw_completed_order_financials v
CROSS JOIN totals t
GROUP BY v.region, t.total_revenue, t.total_profit
ORDER BY net_revenue DESC;


-- 6.3 High revenue but below-average margin regions
WITH company_avg AS (
    SELECT
        CASE
            WHEN SUM(net_revenue) = 0 THEN NULL
            ELSE SUM(gross_profit) / SUM(net_revenue)
        END AS avg_gross_margin
    FROM vw_completed_order_financials
)
SELECT
    region,
    ROUND(SUM(net_revenue), 2) AS net_revenue,
    CASE
        WHEN SUM(net_revenue) = 0 THEN NULL
        ELSE ROUND(SUM(gross_profit) / SUM(net_revenue), 4)
    END AS gross_margin,
    ROUND(ca.avg_gross_margin, 4) AS company_avg_margin
FROM vw_completed_order_financials
CROSS JOIN company_avg ca
GROUP BY region, ca.avg_gross_margin
HAVING CASE
    WHEN SUM(net_revenue) = 0 THEN NULL
    ELSE SUM(gross_profit) / SUM(net_revenue)
END < ca.avg_gross_margin
ORDER BY net_revenue DESC;


-- ============================================================
-- SECTION 7 — DISCOUNT IMPACT ANALYSIS
-- Business question: Are discounts supporting or hurting
-- overall profitability?
-- ============================================================

-- 7.1 Discount band analysis
-- Groups order items into discount bands to compare financial
-- performance across different discount levels.
SELECT
    CASE
        WHEN discount_rate = 0       THEN 'No Discount'
        WHEN discount_rate <= 0.05   THEN 'Low (1-5%)'
        WHEN discount_rate <= 0.15   THEN 'Medium (6-15%)'
        ELSE                              'High (16-25%)'
    END AS discount_band,
    COUNT(*)                     AS order_item_count,
    ROUND(SUM(net_revenue), 2)   AS net_revenue,
    ROUND(SUM(gross_profit), 2)  AS gross_profit,
    CASE
        WHEN SUM(net_revenue) = 0 THEN NULL
        ELSE ROUND(SUM(gross_profit) / SUM(net_revenue), 4)
    END AS gross_margin,
    ROUND(AVG(discount_rate), 4) AS avg_discount_rate
FROM vw_completed_order_financials
GROUP BY
    CASE
        WHEN discount_rate = 0       THEN 'No Discount'
        WHEN discount_rate <= 0.05   THEN 'Low (1-5%)'
        WHEN discount_rate <= 0.15   THEN 'Medium (6-15%)'
        ELSE                              'High (16-25%)'
    END
ORDER BY avg_discount_rate;


-- 7.2 Discount impact by category
SELECT
    category,
    ROUND(AVG(discount_rate), 4) AS avg_discount_rate,
    ROUND(SUM(net_revenue), 2)   AS net_revenue,
    ROUND(SUM(gross_profit), 2)  AS gross_profit,
    CASE
        WHEN SUM(net_revenue) = 0 THEN NULL
        ELSE ROUND(SUM(gross_profit) / SUM(net_revenue), 4)
    END AS gross_margin
FROM vw_completed_order_financials
GROUP BY category
ORDER BY avg_discount_rate DESC;


-- 7.3 Discount impact by customer segment
SELECT
    segment,
    ROUND(AVG(discount_rate), 4) AS avg_discount_rate,
    ROUND(SUM(net_revenue), 2)   AS net_revenue,
    ROUND(SUM(gross_profit), 2)  AS gross_profit,
    CASE
        WHEN SUM(net_revenue) = 0 THEN NULL
        ELSE ROUND(SUM(gross_profit) / SUM(net_revenue), 4)
    END AS gross_margin
FROM vw_completed_order_financials
GROUP BY segment
ORDER BY avg_discount_rate DESC;


-- 7.4 High-discount low-margin items
-- Individual order items with discount > 15% AND gross margin
-- below the company average. These represent discount decisions
-- that may have hurt profitability.
WITH company_avg AS (
    SELECT
        CASE
            WHEN SUM(net_revenue) = 0 THEN NULL
            ELSE SUM(gross_profit) / SUM(net_revenue)
        END AS avg_gross_margin
    FROM vw_completed_order_financials
)
SELECT
    v.order_id,
    v.product_name,
    v.category,
    v.segment,
    v.discount_rate,
    v.net_revenue,
    v.gross_profit,
    v.gross_margin,
    ROUND(ca.avg_gross_margin, 4) AS company_avg_margin
FROM vw_completed_order_financials v
CROSS JOIN company_avg ca
WHERE v.discount_rate > 0.15
  AND v.gross_margin < ca.avg_gross_margin
ORDER BY v.net_revenue DESC
LIMIT 20;


-- ============================================================
-- SECTION 8 — BUDGET VS ACTUAL ANALYSIS
-- Business question: Is the company meeting its monthly
-- revenue and profit targets?
-- ============================================================

-- 8.1 Monthly actual vs target with variance
WITH monthly_actuals AS (
    SELECT
        order_month,
        ROUND(SUM(net_revenue), 2)  AS actual_revenue,
        ROUND(SUM(gross_profit), 2) AS actual_gross_profit
    FROM vw_completed_order_financials
    GROUP BY order_month
)
SELECT
    ma.order_month,
    ma.actual_revenue,
    mt.target_revenue,
    ROUND(ma.actual_revenue - mt.target_revenue, 2) AS revenue_variance,
    CASE
        WHEN mt.target_revenue = 0 THEN NULL
        ELSE ROUND((ma.actual_revenue - mt.target_revenue)
            / mt.target_revenue, 4)
    END AS revenue_variance_pct,
    ma.actual_gross_profit,
    mt.target_gross_profit,
    ROUND(ma.actual_gross_profit - mt.target_gross_profit, 2)
        AS profit_variance,
    CASE
        WHEN mt.target_gross_profit = 0 THEN NULL
        ELSE ROUND((ma.actual_gross_profit - mt.target_gross_profit)
            / mt.target_gross_profit, 4)
    END AS profit_variance_pct,
    CASE
        WHEN ma.actual_revenue >= mt.target_revenue THEN 'Beat'
        ELSE 'Miss'
    END AS performance_status
FROM monthly_actuals ma
JOIN monthly_targets mt
    ON ma.order_month = mt.target_month
ORDER BY ma.order_month;


-- 8.2 Beat vs miss month count
WITH monthly_actuals AS (
    SELECT
        order_month,
        SUM(net_revenue) AS actual_revenue
    FROM vw_completed_order_financials
    GROUP BY order_month
)
SELECT
    SUM(CASE WHEN ma.actual_revenue >= mt.target_revenue
        THEN 1 ELSE 0 END) AS beat_months,
    SUM(CASE WHEN ma.actual_revenue < mt.target_revenue
        THEN 1 ELSE 0 END) AS miss_months
FROM monthly_actuals ma
JOIN monthly_targets mt
    ON ma.order_month = mt.target_month;


-- 8.3 Best and worst target performance months
WITH monthly_actuals AS (
    SELECT
        order_month,
        ROUND(SUM(net_revenue), 2) AS actual_revenue
    FROM vw_completed_order_financials
    GROUP BY order_month
)
SELECT
    ma.order_month,
    ma.actual_revenue,
    mt.target_revenue,
    CASE
        WHEN mt.target_revenue = 0 THEN NULL
        ELSE ROUND((ma.actual_revenue - mt.target_revenue)
            / mt.target_revenue * 100, 1)
    END AS revenue_variance_pct,
    RANK() OVER (
        ORDER BY CASE
            WHEN mt.target_revenue = 0 THEN NULL
            ELSE (ma.actual_revenue - mt.target_revenue) / mt.target_revenue
        END DESC
    ) AS performance_rank
FROM monthly_actuals ma
JOIN monthly_targets mt
    ON ma.order_month = mt.target_month
ORDER BY performance_rank;


-- ============================================================
-- SECTION 9 — ORDER STATUS / CANCELLATION ANALYSIS
-- Business question: How much potential revenue is lost to
-- cancellations and refunds?
--
-- NOTE: This section uses vw_order_item_financials (all statuses)
-- instead of vw_completed_order_financials.
-- ============================================================

-- 9.1 Order status distribution with potential revenue
SELECT
    order_status,
    COUNT(DISTINCT order_id) AS order_count,
    ROUND(SUM(gross_revenue), 2) AS gross_revenue,
    ROUND(COUNT(DISTINCT order_id) * 100.0
        / SUM(COUNT(DISTINCT order_id)) OVER(), 1)
        AS status_share_pct
FROM vw_order_item_financials
GROUP BY order_status
ORDER BY order_count DESC;


-- 9.2 Cancelled and refunded potential value
-- Shows the net revenue and item count that would have been
-- earned if these orders had been completed.
SELECT
    order_status,
    ROUND(SUM(net_revenue), 2) AS potential_net_revenue,
    COUNT(*) AS item_count
FROM vw_order_item_financials
WHERE order_status IN ('Cancelled', 'Refunded')
GROUP BY order_status
ORDER BY potential_net_revenue DESC;


-- ============================================================
-- SECTION 10 — MANAGEMENT INSIGHT QUERIES
-- Business question: What specific actions should management
-- consider based on the data?
-- ============================================================

-- 10.1 Products needing pricing review
-- High revenue products with gross margin below company average
-- may benefit from cost renegotiation or price adjustment.
WITH company_avg AS (
    SELECT SUM(gross_profit) / NULLIF(SUM(net_revenue), 0)
        AS avg_gross_margin
    FROM vw_completed_order_financials
),
product_metrics AS (
    SELECT
        product_name,
        category,
        ROUND(SUM(net_revenue), 2)  AS net_revenue,
        ROUND(SUM(gross_profit), 2) AS gross_profit,
        CASE
            WHEN SUM(net_revenue) = 0 THEN NULL
            ELSE ROUND(SUM(gross_profit) / SUM(net_revenue), 4)
        END AS gross_margin,
        SUM(quantity) AS quantity_sold
    FROM vw_completed_order_financials
    GROUP BY product_name, category
)
SELECT
    pm.*,
    ROUND(ca.avg_gross_margin, 4) AS company_avg_margin
FROM product_metrics pm
CROSS JOIN company_avg ca
WHERE pm.gross_margin < ca.avg_gross_margin
  AND pm.net_revenue > 1000
ORDER BY pm.net_revenue DESC;


-- 10.2 Categories with strong margin but low revenue share
-- These categories may represent growth opportunities: the
-- margin is healthy, but volume is underexploited.
WITH totals AS (
    SELECT SUM(net_revenue) AS total_revenue
    FROM vw_completed_order_financials
),
company_avg AS (
    SELECT SUM(gross_profit) / NULLIF(SUM(net_revenue), 0)
        AS avg_gross_margin
    FROM vw_completed_order_financials
)
SELECT
    v.category,
    ROUND(SUM(v.net_revenue), 2) AS net_revenue,
    ROUND(SUM(v.net_revenue) / NULLIF(t.total_revenue, 0) * 100, 1)
        AS revenue_share_pct,
    CASE
        WHEN SUM(v.net_revenue) = 0 THEN NULL
        ELSE ROUND(SUM(v.gross_profit) / SUM(v.net_revenue), 4)
    END AS gross_margin,
    ROUND(ca.avg_gross_margin, 4) AS company_avg_margin
FROM vw_completed_order_financials v
CROSS JOIN totals t
CROSS JOIN company_avg ca
GROUP BY v.category, t.total_revenue, ca.avg_gross_margin
HAVING SUM(v.gross_profit) / NULLIF(SUM(v.net_revenue), 0) > ca.avg_gross_margin
ORDER BY revenue_share_pct ASC;


-- 10.3 Most valuable customer segments
-- Segments with high average order value AND above-average
-- gross margin are the most attractive for growth focus.
WITH company_avg AS (
    SELECT
        SUM(gross_profit) / NULLIF(SUM(net_revenue), 0) AS avg_gross_margin,
        SUM(net_revenue) / NULLIF(COUNT(DISTINCT order_id), 0) AS avg_aov
    FROM vw_completed_order_financials
)
SELECT
    v.segment,
    COUNT(DISTINCT v.customer_id) AS customer_count,
    ROUND(SUM(v.net_revenue) / NULLIF(COUNT(DISTINCT v.order_id), 0), 2)
        AS average_order_value,
    CASE
        WHEN SUM(v.net_revenue) = 0 THEN NULL
        ELSE ROUND(SUM(v.gross_profit) / SUM(v.net_revenue), 4)
    END AS gross_margin,
    ROUND(ca.avg_aov, 2)             AS company_avg_aov,
    ROUND(ca.avg_gross_margin, 4)    AS company_avg_margin
FROM vw_completed_order_financials v
CROSS JOIN company_avg ca
GROUP BY v.segment, ca.avg_gross_margin, ca.avg_aov
ORDER BY average_order_value DESC;


-- 10.4 Regions with revenue scale but margin weakness
-- These regions generate significant revenue but their margins
-- trail the company average, suggesting pricing, product mix,
-- or discount issues that need operational review.
WITH company_avg AS (
    SELECT SUM(gross_profit) / NULLIF(SUM(net_revenue), 0)
        AS avg_gross_margin
    FROM vw_completed_order_financials
)
SELECT
    v.region,
    ROUND(SUM(v.net_revenue), 2) AS net_revenue,
    CASE
        WHEN SUM(v.net_revenue) = 0 THEN NULL
        ELSE ROUND(SUM(v.gross_profit) / SUM(v.net_revenue), 4)
    END AS gross_margin,
    ROUND(ca.avg_gross_margin, 4) AS company_avg_margin,
    ROUND(AVG(v.discount_rate), 4) AS avg_discount_rate
FROM vw_completed_order_financials v
CROSS JOIN company_avg ca
GROUP BY v.region, ca.avg_gross_margin
HAVING SUM(v.gross_profit) / NULLIF(SUM(v.net_revenue), 0) < ca.avg_gross_margin
ORDER BY net_revenue DESC;


-- 10.5 Months with both revenue miss and profit miss
-- These months need the most attention: both top-line and
-- bottom-line targets were missed simultaneously.
WITH monthly_actuals AS (
    SELECT
        order_month,
        ROUND(SUM(net_revenue), 2)  AS actual_revenue,
        ROUND(SUM(gross_profit), 2) AS actual_gross_profit
    FROM vw_completed_order_financials
    GROUP BY order_month
)
SELECT
    ma.order_month,
    ma.actual_revenue,
    mt.target_revenue,
    ROUND((ma.actual_revenue - mt.target_revenue)
        / NULLIF(mt.target_revenue, 0) * 100, 1) AS revenue_miss_pct,
    ma.actual_gross_profit,
    mt.target_gross_profit,
    ROUND((ma.actual_gross_profit - mt.target_gross_profit)
        / NULLIF(mt.target_gross_profit, 0) * 100, 1) AS profit_miss_pct
FROM monthly_actuals ma
JOIN monthly_targets mt ON ma.order_month = mt.target_month
WHERE ma.actual_revenue < mt.target_revenue
  AND ma.actual_gross_profit < mt.target_gross_profit
ORDER BY revenue_miss_pct ASC;


-- ============================================================
-- NOTES
-- ============================================================
-- This file contains the core financial analysis queries for
-- the SQL Financial Data Analysis project.
--
-- Standard financial analyses use vw_completed_order_financials,
-- which includes only Completed orders.
--
-- Section 9 (cancellation analysis) uses vw_order_item_financials,
-- which includes all order statuses.
--
-- Query results from this file will be interpreted and documented
-- in reports/business_insights.md and reports/executive_summary.md.
-- ============================================================

-- ============================================================
-- 04_financial_metrics_views.sql
-- SQL Financial Data Analysis — Financial Metrics Views
-- ============================================================
-- Creates reusable views that centralize all financial metric
-- calculations. Analysis queries in 05_analysis_queries.sql
-- read from these views instead of repeating formulas.
--
-- Views:
--   1. vw_order_item_financials
--      All order items with calculated financial metrics.
--      Includes all order statuses (Completed, Cancelled, Refunded).
--
--   2. vw_completed_order_financials
--      Filtered version: only Completed orders.
--      Use this view for standard financial analysis.
--
-- Usage guidance:
--   - General financial analysis → vw_completed_order_financials
--   - Cancellation/refund analysis → vw_order_item_financials
-- ============================================================


-- Drop in dependency order (completed view depends on base view)
DROP VIEW IF EXISTS vw_completed_order_financials;
DROP VIEW IF EXISTS vw_order_item_financials;


-- ============================================================
-- View: vw_order_item_financials
-- ============================================================
-- Joins order_items with orders, products, and customers to
-- produce a single denormalized view with all financial metrics
-- calculated at the line-item level.
--
-- Financial metric definitions:
--   gross_revenue   = quantity * unit_price
--   discount_amount = quantity * unit_price * discount_rate
--   net_revenue     = quantity * unit_price * (1 - discount_rate)
--   total_cost      = quantity * unit_cost
--   gross_profit    = net_revenue - total_cost
--   gross_margin    = gross_profit / net_revenue (ratio, not %)
-- ============================================================

CREATE VIEW vw_order_item_financials AS
SELECT
    -- Order information
    o.order_id,
    oi.order_item_id,
    o.order_date,
    DATE_TRUNC('month', o.order_date)::DATE AS order_month,
    o.order_status,
    o.payment_method,
    o.sales_channel,

    -- Customer information
    c.customer_id,
    c.customer_name,
    c.segment,
    c.city,
    c.region,

    -- Product information
    p.product_id,
    p.product_name,
    p.category,

    -- Transaction details
    oi.quantity,
    oi.unit_price,
    p.unit_cost,
    p.standard_price,
    oi.discount_rate,

    -- Financial metrics
    ROUND(oi.quantity * oi.unit_price, 2)
        AS gross_revenue,

    ROUND(oi.quantity * oi.unit_price * oi.discount_rate, 2)
        AS discount_amount,

    ROUND(oi.quantity * oi.unit_price * (1 - oi.discount_rate), 2)
        AS net_revenue,

    ROUND(oi.quantity * p.unit_cost, 2)
        AS total_cost,

    ROUND(oi.quantity * oi.unit_price * (1 - oi.discount_rate)
        - oi.quantity * p.unit_cost, 2)
        AS gross_profit,

    CASE
        WHEN oi.quantity * oi.unit_price * (1 - oi.discount_rate) = 0
            THEN NULL
        ELSE ROUND(
            (oi.quantity * oi.unit_price * (1 - oi.discount_rate)
                - oi.quantity * p.unit_cost)
            / (oi.quantity * oi.unit_price * (1 - oi.discount_rate)),
            4)
    END AS gross_margin

FROM order_items oi
JOIN orders    o ON oi.order_id   = o.order_id
JOIN products  p ON oi.product_id = p.product_id
JOIN customers c ON o.customer_id = c.customer_id;


-- ============================================================
-- View: vw_completed_order_financials
-- ============================================================
-- Convenience view filtered to Completed orders only.
-- All standard financial analyses should use this view.
-- ============================================================

CREATE VIEW vw_completed_order_financials AS
SELECT *
FROM vw_order_item_financials
WHERE order_status = 'Completed';


-- ============================================================
-- Verification queries
-- ============================================================

-- Row counts: base view vs completed-only view
SELECT 'vw_order_item_financials'       AS view_name, COUNT(*) AS row_count
FROM vw_order_item_financials
UNION ALL
SELECT 'vw_completed_order_financials', COUNT(*)
FROM vw_completed_order_financials;

-- Sample output: first 10 rows from completed view
SELECT order_id,
       order_date,
       segment,
       region,
       category,
       quantity,
       unit_price,
       discount_rate,
       gross_revenue,
       net_revenue,
       total_cost,
       gross_profit,
       gross_margin
FROM vw_completed_order_financials
ORDER BY order_item_id
LIMIT 10;

-- ============================================================
-- 03_data_quality_checks.sql
-- SQL Financial Data Analysis — Data Quality Checks
-- ============================================================
-- This script validates data integrity, consistency, and
-- reliability BEFORE running any financial analysis.
--
-- All queries are read-only (SELECT only). No data is modified.
--
-- Structure:
--   1. Row Count Checks
--   2. Primary Key Uniqueness Checks
--   3. Null Checks
--   4. Foreign Key Consistency Checks
--   5. Value Range Checks
--   6. Allowed Value Distribution Checks
--   7. Date Range Checks
--   8. Business Logic Sanity Checks
--   9. Quality Summary
-- ============================================================


-- ============================================================
-- 1. ROW COUNT CHECKS
-- Verify that all tables have the expected number of rows
-- after CSV import.
-- Expected: customers=150, products=50, orders=800,
--           order_items=2110, monthly_targets=12
-- ============================================================

SELECT 'customers'      AS table_name, COUNT(*) AS row_count FROM customers
UNION ALL
SELECT 'products',                     COUNT(*)              FROM products
UNION ALL
SELECT 'orders',                       COUNT(*)              FROM orders
UNION ALL
SELECT 'order_items',                  COUNT(*)              FROM order_items
UNION ALL
SELECT 'monthly_targets',             COUNT(*)              FROM monthly_targets
ORDER BY table_name;


-- ============================================================
-- 2. PRIMARY KEY UNIQUENESS CHECKS
-- Each primary key column must contain only unique values.
-- A result > 0 indicates duplicate keys that must be resolved.
-- ============================================================

-- Duplicate customer_id check
SELECT 'customers.customer_id' AS pk_column,
       COUNT(*) AS duplicate_count
FROM (
    SELECT customer_id
    FROM customers
    GROUP BY customer_id
    HAVING COUNT(*) > 1
) dup;

-- Duplicate product_id check
SELECT 'products.product_id' AS pk_column,
       COUNT(*) AS duplicate_count
FROM (
    SELECT product_id
    FROM products
    GROUP BY product_id
    HAVING COUNT(*) > 1
) dup;

-- Duplicate order_id check
SELECT 'orders.order_id' AS pk_column,
       COUNT(*) AS duplicate_count
FROM (
    SELECT order_id
    FROM orders
    GROUP BY order_id
    HAVING COUNT(*) > 1
) dup;

-- Duplicate order_item_id check
SELECT 'order_items.order_item_id' AS pk_column,
       COUNT(*) AS duplicate_count
FROM (
    SELECT order_item_id
    FROM order_items
    GROUP BY order_item_id
    HAVING COUNT(*) > 1
) dup;

-- Duplicate target_month check
SELECT 'monthly_targets.target_month' AS pk_column,
       COUNT(*) AS duplicate_count
FROM (
    SELECT target_month
    FROM monthly_targets
    GROUP BY target_month
    HAVING COUNT(*) > 1
) dup;


-- ============================================================
-- 3. NULL CHECKS
-- Critical columns must not contain NULL values.
-- Any result > 0 requires investigation before analysis.
-- ============================================================

-- customers null checks
SELECT 'customers' AS table_name,
       SUM(CASE WHEN customer_id IS NULL   THEN 1 ELSE 0 END) AS null_customer_id,
       SUM(CASE WHEN customer_name IS NULL THEN 1 ELSE 0 END) AS null_customer_name,
       SUM(CASE WHEN segment IS NULL       THEN 1 ELSE 0 END) AS null_segment,
       SUM(CASE WHEN region IS NULL        THEN 1 ELSE 0 END) AS null_region
FROM customers;

-- products null checks
SELECT 'products' AS table_name,
       SUM(CASE WHEN product_id IS NULL     THEN 1 ELSE 0 END) AS null_product_id,
       SUM(CASE WHEN product_name IS NULL   THEN 1 ELSE 0 END) AS null_product_name,
       SUM(CASE WHEN category IS NULL       THEN 1 ELSE 0 END) AS null_category,
       SUM(CASE WHEN unit_cost IS NULL      THEN 1 ELSE 0 END) AS null_unit_cost,
       SUM(CASE WHEN standard_price IS NULL THEN 1 ELSE 0 END) AS null_standard_price
FROM products;

-- orders null checks
SELECT 'orders' AS table_name,
       SUM(CASE WHEN order_id IS NULL     THEN 1 ELSE 0 END) AS null_order_id,
       SUM(CASE WHEN order_date IS NULL   THEN 1 ELSE 0 END) AS null_order_date,
       SUM(CASE WHEN customer_id IS NULL  THEN 1 ELSE 0 END) AS null_customer_id,
       SUM(CASE WHEN order_status IS NULL THEN 1 ELSE 0 END) AS null_order_status
FROM orders;

-- order_items null checks
SELECT 'order_items' AS table_name,
       SUM(CASE WHEN order_item_id IS NULL THEN 1 ELSE 0 END) AS null_order_item_id,
       SUM(CASE WHEN order_id IS NULL      THEN 1 ELSE 0 END) AS null_order_id,
       SUM(CASE WHEN product_id IS NULL    THEN 1 ELSE 0 END) AS null_product_id,
       SUM(CASE WHEN quantity IS NULL      THEN 1 ELSE 0 END) AS null_quantity,
       SUM(CASE WHEN unit_price IS NULL    THEN 1 ELSE 0 END) AS null_unit_price,
       SUM(CASE WHEN discount_rate IS NULL THEN 1 ELSE 0 END) AS null_discount_rate
FROM order_items;

-- monthly_targets null checks
SELECT 'monthly_targets' AS table_name,
       SUM(CASE WHEN target_month IS NULL        THEN 1 ELSE 0 END) AS null_target_month,
       SUM(CASE WHEN target_revenue IS NULL      THEN 1 ELSE 0 END) AS null_target_revenue,
       SUM(CASE WHEN target_gross_profit IS NULL THEN 1 ELSE 0 END) AS null_target_gross_profit
FROM monthly_targets;


-- ============================================================
-- 4. FOREIGN KEY CONSISTENCY CHECKS
-- Identify orphan records: child rows referencing non-existent
-- parent rows. A result > 0 indicates broken relationships.
-- ============================================================

-- Orders referencing non-existent customers
SELECT 'orders → customers' AS fk_relationship,
       COUNT(*) AS orphan_count
FROM orders o
LEFT JOIN customers c ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

-- Order items referencing non-existent orders
SELECT 'order_items → orders' AS fk_relationship,
       COUNT(*) AS orphan_count
FROM order_items oi
LEFT JOIN orders o ON oi.order_id = o.order_id
WHERE o.order_id IS NULL;

-- Order items referencing non-existent products
SELECT 'order_items → products' AS fk_relationship,
       COUNT(*) AS orphan_count
FROM order_items oi
LEFT JOIN products p ON oi.product_id = p.product_id
WHERE p.product_id IS NULL;


-- ============================================================
-- 5. VALUE RANGE CHECKS
-- Financial and logical constraints that must hold for
-- accurate analysis. Any result > 0 is a data error.
-- ============================================================

SELECT 'Negative unit_cost'            AS check_name,
       COUNT(*) AS issue_count
FROM products WHERE unit_cost < 0

UNION ALL
SELECT 'Negative standard_price',
       COUNT(*)
FROM products WHERE standard_price < 0

UNION ALL
SELECT 'Price not above cost',
       COUNT(*)
FROM products WHERE standard_price <= unit_cost

UNION ALL
SELECT 'Non-positive quantity',
       COUNT(*)
FROM order_items WHERE quantity <= 0

UNION ALL
SELECT 'Negative unit_price',
       COUNT(*)
FROM order_items WHERE unit_price < 0

UNION ALL
SELECT 'Discount rate out of range',
       COUNT(*)
FROM order_items WHERE discount_rate < 0 OR discount_rate > 0.25

UNION ALL
SELECT 'Negative target_revenue',
       COUNT(*)
FROM monthly_targets WHERE target_revenue < 0

UNION ALL
SELECT 'Negative target_gross_profit',
       COUNT(*)
FROM monthly_targets WHERE target_gross_profit < 0;


-- ============================================================
-- 6. ALLOWED VALUE DISTRIBUTION CHECKS
-- These are not error checks. They show the distribution of
-- categorical values to verify data variety and realism.
-- ============================================================

-- Customer segment distribution
SELECT segment,
       COUNT(*) AS customer_count,
       ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 1) AS pct
FROM customers
GROUP BY segment
ORDER BY customer_count DESC;

-- Customer region distribution
SELECT region,
       COUNT(*) AS customer_count,
       ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 1) AS pct
FROM customers
GROUP BY region
ORDER BY customer_count DESC;

-- Order status distribution
SELECT order_status,
       COUNT(*) AS order_count,
       ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 1) AS pct
FROM orders
GROUP BY order_status
ORDER BY order_count DESC;

-- Payment method distribution
SELECT payment_method,
       COUNT(*) AS order_count,
       ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 1) AS pct
FROM orders
GROUP BY payment_method
ORDER BY order_count DESC;

-- Sales channel distribution
SELECT sales_channel,
       COUNT(*) AS order_count,
       ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 1) AS pct
FROM orders
GROUP BY sales_channel
ORDER BY order_count DESC;

-- Product category distribution
SELECT category,
       COUNT(*) AS product_count,
       ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 1) AS pct
FROM products
GROUP BY category
ORDER BY product_count DESC;


-- ============================================================
-- 7. DATE RANGE CHECKS
-- Verify that date values fall within the expected analysis
-- period (January 2025 – December 2025).
-- ============================================================

-- Order date range
SELECT MIN(order_date) AS earliest_order,
       MAX(order_date) AS latest_order
FROM orders;

-- Orders outside 2025
SELECT COUNT(*) AS orders_outside_2025
FROM orders
WHERE EXTRACT(YEAR FROM order_date) != 2025;

-- Monthly targets: verify 12 distinct months in 2025
SELECT COUNT(DISTINCT target_month) AS distinct_months,
       MIN(target_month)            AS earliest_target,
       MAX(target_month)            AS latest_target
FROM monthly_targets;

-- Monthly targets outside 2025
SELECT COUNT(*) AS targets_outside_2025
FROM monthly_targets
WHERE target_month < '2025-01-01'
   OR target_month > '2025-12-01';


-- ============================================================
-- 8. BUSINESS LOGIC SANITY CHECKS
-- Practical checks to confirm the dataset supports the
-- planned financial analyses.
-- ============================================================

-- Order status breakdown (count and percentage)
SELECT order_status,
       COUNT(*) AS order_count,
       ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM orders), 1) AS pct
FROM orders
GROUP BY order_status
ORDER BY order_count DESC;

-- Orders with no line items (every order should have at least one)
SELECT COUNT(*) AS orders_without_items
FROM orders o
LEFT JOIN order_items oi ON o.order_id = oi.order_id
WHERE oi.order_item_id IS NULL;

-- Products never sold (every product should appear at least once)
SELECT COUNT(*) AS products_never_sold
FROM products p
LEFT JOIN order_items oi ON p.product_id = oi.product_id
WHERE oi.order_item_id IS NULL;

-- Customers who never placed an order
SELECT COUNT(*) AS customers_without_orders
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- Items per order statistics
SELECT ROUND(AVG(item_count), 2) AS avg_items_per_order,
       MIN(item_count)            AS min_items_per_order,
       MAX(item_count)            AS max_items_per_order
FROM (
    SELECT order_id, COUNT(*) AS item_count
    FROM order_items
    GROUP BY order_id
) order_summary;

-- Discount rate statistics
SELECT ROUND(AVG(discount_rate), 4) AS avg_discount_rate,
       MIN(discount_rate)            AS min_discount_rate,
       MAX(discount_rate)            AS max_discount_rate
FROM order_items;

-- Quantity statistics
SELECT ROUND(AVG(quantity), 2) AS avg_quantity,
       MIN(quantity)            AS min_quantity,
       MAX(quantity)            AS max_quantity
FROM order_items;


-- ============================================================
-- 9. QUALITY SUMMARY
-- ============================================================
-- How to interpret these results:
--
-- ERROR CHECKS (sections 2-5, 7):
--   All counts should return 0. Any non-zero result indicates
--   a data issue that must be resolved before financial analysis.
--
-- DISTRIBUTION CHECKS (section 6):
--   These show data characteristics, not errors. Use them to
--   confirm that the dataset has sufficient variety across
--   segments, regions, categories, and channels.
--
-- BUSINESS LOGIC CHECKS (section 8):
--   These verify that the dataset structure supports all
--   planned analyses. Key expectations:
--     - Every order has at least one line item
--     - Every product has been sold at least once
--     - Most customers have placed at least one order
--     - Discount rates and quantities are within expected ranges
--
-- If all error checks return 0, the data is ready for
-- financial analysis (04_financial_metrics_views.sql).
-- ============================================================

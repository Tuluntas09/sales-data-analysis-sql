-- ============================================================
-- 02_import_data.sql
-- SQL Financial Data Analysis — Data Import Script
-- ============================================================
-- Loads CSV files into the database tables using PostgreSQL
-- COPY command.
--
-- IMPORTANT NOTES:
--   1. Run this script from psql in the project root directory:
--      psql -U <username> -d <database> -f sql/02_import_data.sql
--
--   2. COPY requires file paths relative to the psql working
--      directory, OR absolute paths. The paths below assume
--      psql is run from the project root (sql-financial-analysis/).
--
--   3. If using pgAdmin or another GUI tool, use the built-in
--      CSV import wizard or replace \copy with the tool's
--      import functionality.
--
--   4. \copy is the psql client-side variant of COPY. It does
--      not require superuser privileges and reads files from
--      the client machine.
--
--   5. Import order respects foreign key dependencies:
--      customers → products → orders → order_items → monthly_targets
-- ============================================================


-- ============================================================
-- Clear existing data before import
-- ============================================================
-- TRUNCATE in reverse dependency order to respect FK constraints.
-- CASCADE ensures dependent rows are removed automatically.
TRUNCATE TABLE order_items, orders, monthly_targets, products, customers CASCADE;


-- ============================================================
-- Import: customers (no dependencies)
-- ============================================================
\copy customers (customer_id, customer_name, segment, city, region, signup_date) FROM 'data/customers.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',');


-- ============================================================
-- Import: products (no dependencies)
-- ============================================================
\copy products (product_id, product_name, category, unit_cost, standard_price) FROM 'data/products.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',');


-- ============================================================
-- Import: orders (depends on customers)
-- ============================================================
\copy orders (order_id, order_date, customer_id, payment_method, sales_channel, order_status) FROM 'data/orders.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',');


-- ============================================================
-- Import: order_items (depends on orders, products)
-- ============================================================
\copy order_items (order_item_id, order_id, product_id, quantity, unit_price, discount_rate) FROM 'data/order_items.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',');


-- ============================================================
-- Import: monthly_targets (no dependencies)
-- ============================================================
\copy monthly_targets (target_month, target_revenue, target_gross_profit) FROM 'data/monthly_targets.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',');


-- ============================================================
-- Row count verification
-- ============================================================
-- Expected counts:
--   customers:      150
--   products:        50
--   orders:         800
--   order_items:  2,110
--   monthly_targets: 12

SELECT 'customers' AS table_name, COUNT(*) AS row_count FROM customers
UNION ALL
SELECT 'products', COUNT(*) FROM products
UNION ALL
SELECT 'orders', COUNT(*) FROM orders
UNION ALL
SELECT 'order_items', COUNT(*) FROM order_items
UNION ALL
SELECT 'monthly_targets', COUNT(*) FROM monthly_targets
ORDER BY table_name;

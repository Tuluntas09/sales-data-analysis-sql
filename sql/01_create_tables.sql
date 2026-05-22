-- ============================================================
-- 01_create_tables.sql
-- SQL Financial Data Analysis — Table Creation Script
-- ============================================================
-- Creates the relational schema for a retail financial analysis
-- project with primary keys, foreign keys, and check constraints.
--
-- Execution order matters: tables with no dependencies are
-- created first, then tables that reference them.
-- ============================================================

-- Drop tables in reverse dependency order to avoid FK conflicts
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS monthly_targets;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;


-- ============================================================
-- Table: customers
-- Stores customer-level information for segmentation
-- and regional analysis.
-- ============================================================
CREATE TABLE customers (
    customer_id     INTEGER     PRIMARY KEY,
    customer_name   VARCHAR(100) NOT NULL,
    segment         VARCHAR(20) NOT NULL,
    city            VARCHAR(50) NOT NULL,
    region          VARCHAR(10) NOT NULL,
    signup_date     DATE        NOT NULL,

    CONSTRAINT chk_customer_segment CHECK (
        segment IN ('Consumer', 'Corporate', 'Small Business', 'Premium')
    ),
    CONSTRAINT chk_customer_region CHECK (
        region IN ('North', 'South', 'East', 'West', 'Central')
    )
);


-- ============================================================
-- Table: products
-- Stores product catalog with cost and pricing information.
-- unit_cost represents COGS per unit; standard_price is the
-- listed selling price.
-- ============================================================
CREATE TABLE products (
    product_id      INTEGER     PRIMARY KEY,
    product_name    VARCHAR(100) NOT NULL,
    category        VARCHAR(30) NOT NULL,
    unit_cost       NUMERIC(10,2) NOT NULL,
    standard_price  NUMERIC(10,2) NOT NULL,

    CONSTRAINT chk_product_unit_cost CHECK (unit_cost >= 0),
    CONSTRAINT chk_product_standard_price CHECK (standard_price >= 0),
    CONSTRAINT chk_price_above_cost CHECK (standard_price > unit_cost)
);


-- ============================================================
-- Table: orders
-- Stores order header information: when, who, how, and status.
-- Only Completed orders are used in financial analysis;
-- Cancelled and Refunded orders are excluded from revenue
-- and profit calculations.
-- ============================================================
CREATE TABLE orders (
    order_id        INTEGER     PRIMARY KEY,
    order_date      DATE        NOT NULL,
    customer_id     INTEGER     NOT NULL,
    payment_method  VARCHAR(20) NOT NULL,
    sales_channel   VARCHAR(20) NOT NULL,
    order_status    VARCHAR(20) NOT NULL,

    CONSTRAINT fk_order_customer
        FOREIGN KEY (customer_id) REFERENCES customers (customer_id),

    CONSTRAINT chk_payment_method CHECK (
        payment_method IN ('Credit Card', 'Bank Transfer', 'PayPal', 'Cash')
    ),
    CONSTRAINT chk_sales_channel CHECK (
        sales_channel IN ('Online', 'Store', 'Marketplace')
    ),
    CONSTRAINT chk_order_status CHECK (
        order_status IN ('Completed', 'Cancelled', 'Refunded')
    )
);


-- ============================================================
-- Table: order_items
-- Stores line-item level transaction data. This is the core
-- table for financial calculations.
--
-- Key derived metrics (calculated in queries, not stored):
--   gross_revenue  = quantity * unit_price
--   discount_amount = quantity * unit_price * discount_rate
--   net_revenue    = quantity * unit_price * (1 - discount_rate)
--   total_cost     = quantity * unit_cost  (from products table)
--   gross_profit   = net_revenue - total_cost
--   gross_margin   = gross_profit / net_revenue
-- ============================================================
CREATE TABLE order_items (
    order_item_id   INTEGER     PRIMARY KEY,
    order_id        INTEGER     NOT NULL,
    product_id      INTEGER     NOT NULL,
    quantity        INTEGER     NOT NULL,
    unit_price      NUMERIC(10,2) NOT NULL,
    discount_rate   NUMERIC(4,2) NOT NULL DEFAULT 0,

    CONSTRAINT fk_item_order
        FOREIGN KEY (order_id) REFERENCES orders (order_id),
    CONSTRAINT fk_item_product
        FOREIGN KEY (product_id) REFERENCES products (product_id),

    CONSTRAINT chk_item_quantity CHECK (quantity > 0),
    CONSTRAINT chk_item_unit_price CHECK (unit_price >= 0),
    CONSTRAINT chk_item_discount_rate CHECK (
        discount_rate >= 0 AND discount_rate <= 0.25
    )
);


-- ============================================================
-- Table: monthly_targets
-- Stores monthly budget targets for revenue and gross profit.
-- Used for budget vs actual variance analysis.
-- ============================================================
CREATE TABLE monthly_targets (
    target_month        DATE        PRIMARY KEY,
    target_revenue      NUMERIC(12,2) NOT NULL,
    target_gross_profit NUMERIC(12,2) NOT NULL,

    CONSTRAINT chk_target_revenue CHECK (target_revenue >= 0),
    CONSTRAINT chk_target_gross_profit CHECK (target_gross_profit >= 0)
);


-- ============================================================
-- Schema creation complete.
-- Next step: run 02_import_data.sql to load CSV data.
-- ============================================================

# Data Dictionary

This document describes the tables, columns, and data types used in the SQL Financial Data Analysis project.

---

## Table: customers

Stores customer-level information for segmentation and regional analysis.

| Column | Data Type | Description |
|---|---|---|
| customer_id | INTEGER (PK) | Unique customer identifier |
| customer_name | VARCHAR | Full name of the customer |
| segment | VARCHAR | Customer segment: Consumer, Corporate, Small Business, Premium |
| city | VARCHAR | Customer city |
| region | VARCHAR | Geographic region: North, South, East, West, Central |
| signup_date | DATE | Date the customer registered |

---

## Table: products

Stores product catalog with cost and pricing information.

| Column | Data Type | Description |
|---|---|---|
| product_id | INTEGER (PK) | Unique product identifier |
| product_name | VARCHAR | Name of the product |
| category | VARCHAR | Product category: Electronics, Home & Kitchen, Clothing, Sports & Outdoor, Beauty & Personal Care, Office Supplies |
| unit_cost | DECIMAL | Cost per unit (COGS per item) |
| standard_price | DECIMAL | Standard selling price per unit |

---

## Table: orders

Stores order header information.

| Column | Data Type | Description |
|---|---|---|
| order_id | INTEGER (PK) | Unique order identifier |
| order_date | DATE | Date the order was placed |
| customer_id | INTEGER (FK) | References customers.customer_id |
| payment_method | VARCHAR | Payment type: Credit Card, Debit Card, Bank Transfer, Cash |
| sales_channel | VARCHAR | Sales channel: Online, In-Store |
| order_status | VARCHAR | Order status: Completed, Cancelled, Refunded |

---

## Table: order_items

Stores line-item level transaction data. This is the core table for financial calculations.

| Column | Data Type | Description |
|---|---|---|
| order_item_id | INTEGER (PK) | Unique line item identifier |
| order_id | INTEGER (FK) | References orders.order_id |
| product_id | INTEGER (FK) | References products.product_id |
| quantity | INTEGER | Number of units sold |
| unit_price | DECIMAL | Actual selling price per unit for this transaction |
| discount_rate | DECIMAL | Discount applied as a decimal (e.g., 0.10 = 10%) |

### Derived Financial Metrics from order_items

These metrics are not stored as columns but are calculated in queries:

| Metric | Formula | Description |
|---|---|---|
| Gross Revenue | quantity * unit_price | Total sales value before discount |
| Discount Amount | quantity * unit_price * discount_rate | Revenue lost to discounts |
| Net Revenue | quantity * unit_price * (1 - discount_rate) | Actual revenue after discount |
| Total Cost | quantity * unit_cost | Cost of goods sold (unit_cost from products table) |
| Gross Profit | net_revenue - total_cost | Profit after cost of goods |
| Gross Margin | gross_profit / net_revenue | Profitability ratio (protected against division by zero) |

---

## Table: monthly_targets

Stores monthly budget targets for revenue and gross profit.

| Column | Data Type | Description |
|---|---|---|
| target_month | DATE | First day of the target month (e.g., 2025-01-01) |
| target_revenue | DECIMAL | Revenue target for the month |
| target_gross_profit | DECIMAL | Gross profit target for the month |

---

## Relationships

```
customers (1) ──── (N) orders
orders    (1) ──── (N) order_items
products  (1) ──── (N) order_items
```

- Each customer can have multiple orders.
- Each order can have multiple order items (line items).
- Each product can appear in multiple order items.
- monthly_targets is a standalone reference table with no foreign keys.

---

## Business Logic Notes

1. Only orders with `order_status = 'Completed'` are included in financial analysis.
2. Cancelled and refunded orders are excluded from revenue and profit calculations.
3. Discount rate is stored as a decimal between 0 and 1.
4. Unit cost comes from the products table; unit price may vary per transaction in order_items.
5. This project analyzes gross profit, not net profit (operating expenses are excluded).
6. No tax, shipping, or payment processing fees are included.

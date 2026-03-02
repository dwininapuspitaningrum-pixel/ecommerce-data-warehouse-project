/*
==========================================================================
DDL Script: Create Gold Views
==========================================================================
Script Purpose:
  This script recreates views for the Gold layer in the data warehouse.
  The Gold layer represents the final dimension and fact tables (Star Schema)

  Each view performs transfromations and combines data from the Silver layer
  to produce a clean, enriched, and business-ready dataset.

Usage:
  - These views can be queried directly for analytics and reporting.
==========================================================================
*/

-- =============================================================================
-- Create Dimension: gold.dim_customers
-- =============================================================================
IF OBJECT_ID('gold.dim_customers', 'V') IS NOT NULL
    DROP VIEW gold.dim_customers;
GO
CREATE VIEW gold.dim_customers AS
SELECT
	ROW_NUMBER() OVER(ORDER BY c.customer_id) AS customer_key,
	c.customer_id AS customer_id,
	c.customer_name AS customer_name,
	c.email AS email,
	c.city AS city,
	c.customer_state AS state,
	c.signup_date AS signup_date
FROM silver.customers AS c;

-- =============================================================================
-- Create Dimension: gold.dim_products
-- =============================================================================
IF OBJECT_ID('gold.dim_products', 'V') IS NOT NULL
    DROP VIEW gold.dim_products;
GO
CREATE VIEW gold.dim_products AS
SELECT
	ROW_NUMBER() OVER(ORDER BY p.product_id) AS product_key,
	p.product_id AS product_id,
	p.product_name AS product_name,
	cat.cat_id AS category_id,
	cat.cat_name AS category_name,
	p.price AS price,
	p.cost_price AS cost_price
FROM silver.products AS p
LEFT JOIN silver.categories AS cat
ON p.category_id = cat.cat_id;

-- =============================================================================
-- Create Fact Table: gold.fact_sales
-- =============================================================================
IF OBJECT_ID('gold.fact_sales', 'V') IS NOT NULL
    DROP VIEW gold.fact_sales;
GO
CREATE VIEW gold.fact_sales AS
SELECT
	ROW_NUMBER() OVER(ORDER BY oit.order_id) AS sales_key,
	oit.order_id AS order_id,
	dc.customer_key AS customer_key,
	dp.product_key AS product_key,
	oit.quantity AS quantity,
	oit.unit_price AS unit_price,
	oit.sales AS sales,
	o.payment_method AS payment_method,
	o.order_status AS order_status,
	r.refund_amount AS refund_amount
FROM silver.order_items AS oit
LEFT JOIN silver.orders AS o
ON oit.order_id = o.order_id
LEFT JOIN silver.returns AS r
ON r.order_item_id = oit.order_item_id
LEFT JOIN gold.dim_customers AS dc
ON dc.customer_id = o.customer_id
LEFT JOIN gold.dim_products AS dp
ON dp.product_id = oit.product_id;


/*
==========================================================================
Quality Checks
==========================================================================
Script Purpose:
  This script performs various quality checks for data consistency, accuracy,
  and standardization across the 'silver' schemas. It includes checks for:
  - Null or duplicate primary keys.
  - Unwanted spaces in string fields.
  - Data standardization and consistency.
  - Invalid date ranges and orders.
  - Data consistency between related fields.

Usage Notes:
  - Run these checks after data loading Silver layer.
  - Investigate and resolve any disrepancies found during the checks.
==========================================================================
*/

/*
===============================================================================
Quality Checks
===============================================================================
Script Purpose:
    This script performs various quality checks for data consistency, accuracy, 
    and standardization across the 'silver' layer. It includes checks for:
    - Null or duplicate primary keys.
    - Unwanted spaces in string fields.
    - Data standardization and consistency.
    - Invalid date ranges and orders.
    - Data consistency between related fields.

Usage Notes:
    - Run these checks after data loading Silver Layer.
    - Investigate and resolve any discrepancies found during the checks.
===============================================================================
*/

-- ====================================================================
-- Checking 'silver.categories'
-- ====================================================================

-- Check for NULLs or Duplicates in Primary Key
-- Expectation: No Results
SELECT 
    cat_id,
    COUNT(*) 
FROM silver.categories
GROUP BY cat_id
HAVING COUNT(*) > 1 OR cat_id IS NULL;

-- Check for Unwanted Spaces
-- Expectation: No Results
SELECT 
    cat_name 
FROM silver.categories
WHERE cat_name != TRIM(cat_name);

-- ====================================================================
-- Checking 'silver.customers'
-- ====================================================================

-- Check for NULLs or Duplicates in Primary Key
-- Expectation: No Results
SELECT 
    customer_id,
    COUNT(*) 
FROM silver.customers
GROUP BY  customer_id
HAVING COUNT(*) > 1 OR  customer_id IS NULL;

-- Check for Unwanted Spaces
-- Expectation: No Results
SELECT 
    customer_name 
FROM silver.customers
WHERE customer_name != TRIM(customer_name);

SELECT 
    email 
FROM silver.customers
WHERE email != TRIM(email);

SELECT 
    city 
FROM silver.customers
WHERE city != TRIM(city);

SELECT 
    customer_state 
FROM silver.customers
WHERE customer_state != TRIM(customer_state);

-- Check for Invalid Dates
-- Expectation: No Invalid Dates
SELECT 
	signup_date
FROM silver.customers
WHERE signup_date IS NULL
   OR signup_date > GETDATE()
   OR signup_date < '1900-01-01';

-- Data Standardization & Consistency
SELECT DISTINCT
	city
FROM silver.customers;

-- ====================================================================
-- Checking 'silver.order_items'
-- ====================================================================

-- Check for NULLs or Duplicates in Primary Key
-- Expectation: No Results
SELECT 
    order_item_id,
    COUNT(*) 
FROM silver.orders
GROUP BY order_item_id
HAVING COUNT(*) > 1 OR  order_item_id IS NULL;

-- ====================================================================
-- Checking 'silver.orders'
-- ====================================================================

-- Check for NULLs or Duplicates in Primary Key
-- Expectation: No Results
SELECT 
    order_id,
    COUNT(*) 
FROM silver.orders
GROUP BY order_id
HAVING COUNT(*) > 1 OR  order_id IS NULL;

-- Data Standardization & Consistency
SELECT DISTINCT
	order_status
FROM silver.orders;

SELECT DISTINCT
	payment_method
FROM silver.orders;

-- ====================================================================
-- Checking 'silver.products'
-- ====================================================================

-- Check for NULLs or Duplicates in Primary Key
-- Expectation: No Results
SELECT 
    product_id,
    COUNT(*) 
FROM silver.products
GROUP BY product_id
HAVING COUNT(*) > 1 OR  product_id IS NULL;

-- Data Standardization & Consistency
SELECT DISTINCT 
    product_name
FROM silver.products
ORDER BY product_name;

-- ====================================================================
-- Checking 'silver.returns'
-- ====================================================================

-- Check for NULLs or Duplicates in Primary Key
-- Expectation: No Results
SELECT 
    return_id,
    COUNT(*) 
FROM silver.returns
GROUP BY return_id
HAVING COUNT(*) > 1 OR  return_id IS NULL;

-- Check for Invalid Dates
-- Expectation: No Invalid Dates
SELECT 
	return_date
FROM silver.returns
WHERE return_date IS NULL
   OR return_date > GETDATE()
   OR return_date < '1900-01-01';


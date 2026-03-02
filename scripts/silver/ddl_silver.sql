/*
===============================================================================
DDL Script: Create Silver Tables
===============================================================================
Script Purpose:
    This script creates tables in the 'silver' schema, dropping existing tables 
    if they already exist.
	  Run this script to re-define the DDL structure of 'silver' Tables
===============================================================================
*/

IF OBJECT_ID ('silver.categories', 'U') IS NOT NULL
	DROP TABLE silver.categories; -- check whether the table is already exist or not
CREATE TABLE silver.categories (
	cat_id		INT,
	cat_name	NVARCHAR(50)
);
GO

IF OBJECT_ID ('silver.customers', 'U') IS NOT NULL
	DROP TABLE silver.customers;
CREATE TABLE silver.customers (
	customer_id		INT,
	customer_name	NVARCHAR(50),
	email			NVARCHAR(50),
	signup_date		DATE,
	city			NVARCHAR(50),
	customer_state	NVARCHAR(50)
);
GO

IF OBJECT_ID ('silver.order_items', 'U') IS NOT NULL
	DROP TABLE silver.order_items;
CREATE TABLE silver.order_items (
	order_item_id	INT,
	order_id		INT,
	product_id		INT,
	quantity		INT,
	unit_price		DECIMAL(10,2),
	sales			DECIMAL(10,2)
);
GO

IF OBJECT_ID ('silver.orders', 'U') IS NOT NULL
	DROP TABLE silver.orders;
CREATE TABLE silver.orders(
	order_id		INT,
	customer_id		INT,
	order_status	NVARCHAR(50),
	payment_method	NVARCHAR(50)
);
GO

IF OBJECT_ID ('silver.products', 'U') IS NOT NULL
	DROP TABLE silver.products;
CREATE TABLE silver.products(
	product_id		INT,
	product_name	NVARCHAR(50),
	category_id		INT,
	price			DECIMAL(10,2),
	cost_price		DECIMAL(10,2)
);
GO

IF OBJECT_ID ('silver.returns', 'U') IS NOT NULL
	DROP TABLE silver.returns;
CREATE TABLE silver.returns(
	return_id		INT,
	order_item_id	INT,
	return_date		DATE,
	refund_amount	DECIMAL(10,2)
);
GO


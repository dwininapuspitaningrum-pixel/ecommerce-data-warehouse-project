/*
===============================================================================
DDL Script: Create Bronze Tables
===============================================================================
Script Purpose:
    This script creates tables in the 'bronze' schema, dropping existing tables 
    if they already exist.
	  Run this script to re-define the DDL structure of 'bronze' Tables
===============================================================================
*/

IF OBJECT_ID ('bronze.categories', 'U') IS NOT NULL
	DROP TABLE bronze.categories; -- check whether the table is already exist or not
CREATE TABLE bronze.categories (
	cat_id		INT,
	cat_name	NVARCHAR(50)
);
GO

IF OBJECT_ID ('bronze.customers', 'U') IS NOT NULL
	DROP TABLE bronze.customers;
CREATE TABLE bronze.customers (
	customer_id		INT,
	customer_name	NVARCHAR(50),
	email			NVARCHAR(50),
	signup_date		DATE,
	city			NVARCHAR(50),
	customer_state	NVARCHAR(50)
);
GO

IF OBJECT_ID ('bronze.order_items', 'U') IS NOT NULL
	DROP TABLE bronze.order_items;
CREATE TABLE bronze.order_items (
	order_item_id	INT,
	order_id		INT,
	product_id		INT,
	quantity		INT,
	unit_price		DECIMAL(10,2)
);
GO

IF OBJECT_ID ('bronze.orders', 'U') IS NOT NULL
	DROP TABLE bronze.orders;
CREATE TABLE bronze.orders(
	order_id		INT,
	customer_id		INT,
	order_status	NVARCHAR(50),
	payment_method	NVARCHAR(50)
);
GO

IF OBJECT_ID ('bronze.products', 'U') IS NOT NULL
	DROP TABLE bronze.products;
CREATE TABLE bronze.products(
	product_id		INT,
	product_name	NVARCHAR(50),
	category_id		INT,
	price			DECIMAL(10,2),
	cost_price		DECIMAL(10,2)
);
GO

IF OBJECT_ID ('bronze.returns', 'U') IS NOT NULL
	DROP TABLE bronze.returns;
CREATE TABLE bronze.returns(
	return_id		INT,
	order_item_id	INT,
	return_date		DATE,
	refund_amount	DECIMAL(10,2)
);
GO


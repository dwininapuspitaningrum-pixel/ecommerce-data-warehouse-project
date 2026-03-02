/*
===============================================================================
Stored Procedure: Load Silver Layer (Source -> silver)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'silver' schema from external CSV files. 
    It performs the following actions:
    - Truncates the silver tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to silver tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC silver.load_silver;
===============================================================================
*/

CREATE OR ALTER PROCEDURE silver.load_silver AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
	BEGIN TRY
		SET @batch_start_time = GETDATE();
		PRINT '===================================';
		PRINT 'Loading silver Layer';
		PRINT '===================================';

		SET @start_time = GETDATE();
		PRINT'>> Truncating Table: silver.categories';
		TRUNCATE TABLE silver.categories;
		PRINT'>> Inserting Data Into: silver.categories';
		INSERT INTO silver.categories (
			cat_id,
			cat_name)
		SELECT
			cat_id,
			cat_name
		FROM bronze.categories;
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '------------------------------';

		SET @start_time = GETDATE();
		PRINT'>> Truncating Table: silver.customers';
		TRUNCATE TABLE silver.customers;
		PRINT'>> Inserting Data Into: silver.customers';
		INSERT INTO silver.customers (
			customer_id,
			customer_name,
			email,
			signup_date,
			city,
			customer_state)
		SELECT
			customer_id,
			customer_name,
			email,
			signup_date,
			city,
			customer_state
		FROM bronze.customers;
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '------------------------------';

		SET @start_time = GETDATE();
		PRINT'>> Truncating Table: silver.order_items';
		TRUNCATE TABLE silver.order_items;
		PRINT'>> Inserting Data Into: silver.order_items';
		INSERT INTO silver.order_items (
			order_item_id,
			order_id,
			product_id,
			quantity,
			unit_price,
			sales)
		SELECT
			order_item_id,
			order_id,
			product_id,
			quantity,
			unit_price,
			quantity * unit_price AS sales
		FROM bronze.order_items;
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '------------------------------';

		SET @start_time = GETDATE();
		PRINT'>> Truncating Table: silver.orders';
		TRUNCATE TABLE silver.orders;
		PRINT'>> Inserting Data Into: silver.orders';
		INSERT INTO silver.orders (
			order_id,
			customer_id,
			order_status,
			payment_method)
		SELECT 
			order_id,
			customer_id,
			order_status,
			payment_method
		FROM bronze.orders;
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '------------------------------';

		SET @start_time = GETDATE();
		PRINT'>> Truncating Table: silver.products';
		TRUNCATE TABLE silver.products;
		PRINT'>> Inserting Data Into: silver.products';
		INSERT INTO silver.products (
			product_id,
			product_name,
			category_id,
			price,
			cost_price)
		SELECT
			product_id,
			product_name,
			category_id,
			price,
			cost_price
		FROM bronze.products;
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '------------------------------';

		SET @start_time = GETDATE();
		PRINT'>> Truncating Table: silver.returns';
		TRUNCATE TABLE silver.returns;
		PRINT'>> Inserting Data Into: silver.returns';
		INSERT INTO silver.returns (
			return_id,
			order_item_id,
			return_date,
			refund_amount)
		SELECT
			return_id,
			order_item_id,
			return_date,
			refund_amount
		FROM bronze.returns	
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '------------------------------';

		SET @batch_end_time = GETDATE();
		PRINT '==========================================';
		PRINT 'Loading silver Layer is Completed';
        PRINT '   - Total Load Duration: ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';
		PRINT '==========================================';
	END TRY
	BEGIN CATCH
		PRINT '=========================================';
		PRINT 'ERROR OCCURED DURING LOADING silver LAYER';
		PRINT 'Error Message' + ERROR_MESSAGE ();
		PRINT 'Error Message' + CAST (ERROR_NUMBER () AS NVARCHAR);
		PRINT 'Error Message' + CAST (ERROR_STATE () AS NVARCHAR);
		PRINT '=========================================';
	END CATCH
END;
GO

EXEC silver.load_silver;

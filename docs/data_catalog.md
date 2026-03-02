Data Dictionary for Gold Layer

Overview
The Gold Layer is the business-level data representation, structured to support analytical and reporting use cases. It consists of dimension tables and fact tables for specific business metrics.

1. gold.dim_customers
    - Purpose: Stores customer details enriched with demographic and account information.
    - Coulmns:

    | Column Name | Data Type | Description |
    | --- | --- | --- |
    | customer_key | INT | Surrogate key uniquely identifying each customer record in the dimension table. |
    | customer_id | INT | Unique numerical identifier assigned to each customer |
    | customer_name | NVARCHAR(50) | The customer’s full name, as recorded in the system |
    | email | NVARCHAR(50) | The email address of customers |
    | city | NVARCHAR(50) | The city of residence for the customer (e.g., ‘Udaipur’) |
    | customer_state | NVARCHAR(50) | The state of residence for the customer (e.g., ‘Rajashtan’) |
    | signup_date | DATE | The date when the customer signuprecord was created in the system |

2. gold.dim_products
    - Purpose: Provides information about the products and their attributes including pricing and cost information.
    - Column:
    
    | Column Name | Data Type | Description |
    | --- | --- | --- |
    | product_key | INT | Surrogate key uniquely identifying each customer record in the dimension table. |
    | product_id | INT | A unique identifier assigned to the product for internal tracking and referencing |
    | product_name | NVARCHAR(50) | Descriptive name of the product |
    | category_id | INT | A unique identifier for the product’s category, linking to its high-level classification |
    | category_name | NVARCHAR(50) | The broader classification of the product (e.g., Electronics, Toys) to group related items |
    | price | DECIMAL(10,2) | The sales price of the product, measured in monetary units |
    | cost | DECIMAL(10,2) | The cost or base price of the product, measured in monetary units |

3. gold.fact_sales

- Purpose: Stores transactional sales data for analytical purposes.
- Column:

    | Column Name | Data Type | Description |
    | --- | --- | --- |
    | sales_key | INT | Surrogate key uniquely identifying each customer record in the fact table. |
    | order_id | INT | A unique numeric identifier for each sales order |
    | customer_key | INT | Surrogate key linking the order to the customer dimension table |
    | product_key | INT | Surrogate key linking the order to the product dimension table |
    | quantity | INT | The number of units of the product ordered for the line item (e.g., 1) |
    | unit_price | DECIMAL(10,2) | The price per unit of the product for the line item, in decimal currency units (e.g., 9498.37) |
    | sales | DECIMAL(10,2) | The total monetary value of the sale for line item, in decimal currency units (e.g., 9498.37) |
    | payment_method | DATE | The method of payment chosen by customers |
    | order_status | NVARCHAR(50) | The status of the order to date |
    | refund_amount | DECIMAL(10,2) | The total monetary value of the refund for line item, in decimal currency units (e.g., 9498.37) |
    
    
    
    
  


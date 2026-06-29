CREATE TABLE [stg].[fact_sales] (

	[sale_id] varchar(8000) NULL, 
	[customer_id] varchar(8000) NULL, 
	[product id] varchar(8000) NULL, 
	[store_id] varchar(8000) NULL, 
	[promotion_id] varchar(8000) NULL, 
	[quantity] float NULL, 
	[unit_price] float NULL, 
	[discount_amt] float NULL, 
	[revenue] float NULL, 
	[discount_pct] bigint NULL, 
	[sale_date_clean] date NULL
);
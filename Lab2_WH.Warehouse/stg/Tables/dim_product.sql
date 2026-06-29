CREATE TABLE [stg].[dim_product] (

	[product_key] bigint NULL, 
	[product_id] varchar(8000) NULL, 
	[product_name] varchar(8000) NULL, 
	[category] varchar(8000) NULL, 
	[subcategory] varchar(8000) NULL, 
	[brand] varchar(8000) NULL, 
	[cost_price] bigint NULL, 
	[list_price] bigint NULL
);
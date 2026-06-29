CREATE TABLE [dbo].[agg_sales_by_product] (

	[product id] varchar(8000) NULL, 
	[sale_id] varchar(8000) NULL, 
	[store_id] varchar(8000) NULL, 
	[sale_date_clean] date NULL, 
	[sum_revenue] float NULL, 
	[sum_quantity] float NULL, 
	[count_sale_id] bigint NULL
);
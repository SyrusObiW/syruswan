CREATE TABLE [stg].[dim_promotion] (

	[promotion_key] bigint NULL, 
	[promotion_name] varchar(8000) NULL, 
	[promotion_type] varchar(8000) NULL, 
	[discount_pct] bigint NULL, 
	[start_date] date NULL, 
	[end_date] date NULL
);
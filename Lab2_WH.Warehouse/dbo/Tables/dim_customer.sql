CREATE TABLE [dbo].[dim_customer] (

	[customer_key] bigint NULL, 
	[customer_id] varchar(8000) NULL, 
	[full_name] varchar(8000) NULL, 
	[email] varchar(8000) NULL, 
	[city] varchar(8000) NULL, 
	[country] varchar(8000) NULL, 
	[segment] varchar(8000) NULL, 
	[created_date] date NULL
);
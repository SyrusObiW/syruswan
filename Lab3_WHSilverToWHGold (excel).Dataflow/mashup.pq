[StagingDefinition = [Kind = "FastCopy"]]
section Section1;
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "stg dim_customer_DataDestination", IsNewTarget = true], Settings = [Kind = "Manual", AllowCreation = true, ColumnSettings = [Mappings = {[SourceColumnName = "customer_key", DestinationColumnName = "customer_key"], [SourceColumnName = "customer_id", DestinationColumnName = "customer_id"], [SourceColumnName = "full_name", DestinationColumnName = "full_name"], [SourceColumnName = "email", DestinationColumnName = "email"], [SourceColumnName = "city", DestinationColumnName = "city"], [SourceColumnName = "country", DestinationColumnName = "country"], [SourceColumnName = "segment", DestinationColumnName = "segment"], [SourceColumnName = "created_date", DestinationColumnName = "created_date"]}], DynamicSchema = false, UpdateMethod = [Kind = "Replace"], TypeSettings = [Kind = "Table"]]]}]
shared #"stg dim_customer" = let
  來源 = Fabric.Warehouse(null),
  巡覽 = 來源{[workspaceId = "f42c5981-42e2-4f68-9985-cf204aaab82c"]}[Data],
  #"巡覽 1" = 巡覽{[warehouseId = "f70efe4c-20fc-4531-92be-1619a01cd29d"]}[Data],
  #"巡覽 2" = #"巡覽 1"{[Schema = "stg", Item = "dim_customer"]}[Data]
in
  #"巡覽 2";
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "stg dim_product_DataDestination", IsNewTarget = true], Settings = [Kind = "Manual", AllowCreation = true, ColumnSettings = [Mappings = {[SourceColumnName = "product_key", DestinationColumnName = "product_key"], [SourceColumnName = "product_id", DestinationColumnName = "product_id"], [SourceColumnName = "product_name", DestinationColumnName = "product_name"], [SourceColumnName = "category", DestinationColumnName = "category"], [SourceColumnName = "subcategory", DestinationColumnName = "subcategory"], [SourceColumnName = "brand", DestinationColumnName = "brand"], [SourceColumnName = "cost_price", DestinationColumnName = "cost_price"], [SourceColumnName = "list_price", DestinationColumnName = "list_price"]}], DynamicSchema = false, UpdateMethod = [Kind = "Append"], TypeSettings = [Kind = "Table"]]]}]
shared #"stg dim_product" = let
  來源 = Fabric.Warehouse(null),
  巡覽 = 來源{[workspaceId = "f42c5981-42e2-4f68-9985-cf204aaab82c"]}[Data],
  #"巡覽 1" = 巡覽{[warehouseId = "f70efe4c-20fc-4531-92be-1619a01cd29d"]}[Data],
  #"巡覽 2" = #"巡覽 1"{[Schema = "stg", Item = "dim_product"]}[Data]
in
  #"巡覽 2";
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "stg dim_promotion_DataDestination", IsNewTarget = true], Settings = [Kind = "Manual", AllowCreation = true, ColumnSettings = [Mappings = {[SourceColumnName = "promotion_key", DestinationColumnName = "promotion_key"], [SourceColumnName = "promotion_name", DestinationColumnName = "promotion_name"], [SourceColumnName = "promotion_type", DestinationColumnName = "promotion_type"], [SourceColumnName = "discount_pct", DestinationColumnName = "discount_pct"], [SourceColumnName = "start_date", DestinationColumnName = "start_date"], [SourceColumnName = "end_date", DestinationColumnName = "end_date"]}], DynamicSchema = false, UpdateMethod = [Kind = "Replace"], TypeSettings = [Kind = "Table"]]]}]
shared #"stg dim_promotion" = let
  來源 = Fabric.Warehouse(null),
  巡覽 = 來源{[workspaceId = "f42c5981-42e2-4f68-9985-cf204aaab82c"]}[Data],
  #"巡覽 1" = 巡覽{[warehouseId = "f70efe4c-20fc-4531-92be-1619a01cd29d"]}[Data],
  #"巡覽 2" = #"巡覽 1"{[Schema = "stg", Item = "dim_promotion"]}[Data]
in
  #"巡覽 2";
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "stg dim_store_DataDestination", IsNewTarget = true], Settings = [Kind = "Manual", AllowCreation = true, ColumnSettings = [Mappings = {[SourceColumnName = "store_key", DestinationColumnName = "store_key"], [SourceColumnName = "store_id", DestinationColumnName = "store_id"], [SourceColumnName = "store_name", DestinationColumnName = "store_name"], [SourceColumnName = "city", DestinationColumnName = "city"], [SourceColumnName = "country", DestinationColumnName = "country"], [SourceColumnName = "region", DestinationColumnName = "region"], [SourceColumnName = "store_type", DestinationColumnName = "store_type"], [SourceColumnName = "open_year", DestinationColumnName = "open_year"]}], DynamicSchema = false, UpdateMethod = [Kind = "Replace"], TypeSettings = [Kind = "Table"]]]}]
shared #"stg dim_store" = let
  來源 = Fabric.Warehouse(null),
  巡覽 = 來源{[workspaceId = "f42c5981-42e2-4f68-9985-cf204aaab82c"]}[Data],
  #"巡覽 1" = 巡覽{[warehouseId = "f70efe4c-20fc-4531-92be-1619a01cd29d"]}[Data],
  #"巡覽 2" = #"巡覽 1"{[Schema = "stg", Item = "dim_store"]}[Data]
in
  #"巡覽 2";
[StagingDefinition = [Kind = "FastCopy", Required = true]]
shared #"stg fact_sales" = let
  來源 = Fabric.Warehouse(null),
  巡覽 = 來源{[workspaceId = "f42c5981-42e2-4f68-9985-cf204aaab82c"]}[Data],
  #"巡覽 1" = 巡覽{[warehouseId = "f70efe4c-20fc-4531-92be-1619a01cd29d"]}[Data],
  #"巡覽 2" = #"巡覽 1"{[Schema = "stg", Item = "fact_sales"]}[Data]
in
  #"巡覽 2";
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "agg_sales_by_customer_DataDestination", IsNewTarget = true], Settings = [Kind = "Manual", AllowCreation = true, ColumnSettings = [Mappings = {[SourceColumnName = "customer_id", DestinationColumnName = "customer_id"], [SourceColumnName = "sale_date_clean", DestinationColumnName = "sale_date_clean"], [SourceColumnName = "store_id", DestinationColumnName = "store_id"], [SourceColumnName = "sale_id", DestinationColumnName = "sale_id"], [SourceColumnName = "sum_revenue", DestinationColumnName = "sum_revenue"], [SourceColumnName = "sum_quantity", DestinationColumnName = "sum_quantity"], [SourceColumnName = "count_sale_id", DestinationColumnName = "count_sale_id"]}], DynamicSchema = false, UpdateMethod = [Kind = "Replace"], TypeSettings = [Kind = "Table"]]]}]
shared agg_sales_by_customer = let
  來源 = #"stg fact_sales",
  已分組的資料列 = Table.Group(來源, {"customer_id", "sale_date_clean", "store_id", "sale_id"}, {{"sum_revenue", each List.Sum([revenue]), type nullable number}, {"sum_quantity", each List.Sum([quantity]), type nullable number}, {"count_sale_id", each Table.RowCount(_), Int64.Type}})
in
  已分組的資料列;
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "agg_sales_by_product_DataDestination", IsNewTarget = true], Settings = [Kind = "Manual", AllowCreation = true, ColumnSettings = [Mappings = {[SourceColumnName = "product id", DestinationColumnName = "product id"], [SourceColumnName = "sale_id", DestinationColumnName = "sale_id"], [SourceColumnName = "store_id", DestinationColumnName = "store_id"], [SourceColumnName = "sale_date_clean", DestinationColumnName = "sale_date_clean"], [SourceColumnName = "sum_revenue", DestinationColumnName = "sum_revenue"], [SourceColumnName = "sum_quantity", DestinationColumnName = "sum_quantity"], [SourceColumnName = "count_sale_id", DestinationColumnName = "count_sale_id"]}], DynamicSchema = false, UpdateMethod = [Kind = "Replace"], TypeSettings = [Kind = "Table"]]]}]
shared agg_sales_by_product = let
  來源 = #"stg fact_sales",
  已分組的資料列 = Table.Group(來源, {"product id", "sale_id", "store_id", "sale_date_clean"}, {{"sum_revenue", each List.Sum([revenue]), type nullable number}, {"sum_quantity", each List.Sum([quantity]), type nullable number}, {"count_sale_id", each Table.RowCount(_), Int64.Type}})
in
  已分組的資料列;
shared #"stg dim_product_DataDestination" = let
  Pattern = Fabric.Warehouse([CreateNavigationProperties = false, HierarchicalNavigation = true]),
  Navigation_1 = Pattern{[workspaceId = "."]}[Data],
  Navigation_2 = Navigation_1{[displayName = "Lab2_WH"]}[Data],
  Navigation_3 = Navigation_2{[Schema = "dbo"]}[Data],
  TableNavigation = Navigation_3{[Name = "dim_product"]}?[Data]?
in
  TableNavigation;
shared #"stg dim_customer_DataDestination" = let
  Pattern = Fabric.Warehouse([CreateNavigationProperties = false, HierarchicalNavigation = true]),
  Navigation_1 = Pattern{[workspaceId = "."]}[Data],
  Navigation_2 = Navigation_1{[displayName = "Lab2_WH"]}[Data],
  Navigation_3 = Navigation_2{[Schema = "dbo"]}[Data],
  TableNavigation = Navigation_3{[Name = "dim_customer"]}?[Data]?
in
  TableNavigation;
shared #"stg dim_promotion_DataDestination" = let
  Pattern = Fabric.Warehouse([CreateNavigationProperties = false, HierarchicalNavigation = true]),
  Navigation_1 = Pattern{[workspaceId = "."]}[Data],
  Navigation_2 = Navigation_1{[displayName = "Lab2_WH"]}[Data],
  Navigation_3 = Navigation_2{[Schema = "dbo"]}[Data],
  TableNavigation = Navigation_3{[Name = "dim_promotion"]}?[Data]?
in
  TableNavigation;
shared #"stg dim_store_DataDestination" = let
  Pattern = Fabric.Warehouse([CreateNavigationProperties = false, HierarchicalNavigation = true]),
  Navigation_1 = Pattern{[workspaceId = "."]}[Data],
  Navigation_2 = Navigation_1{[displayName = "Lab2_WH"]}[Data],
  Navigation_3 = Navigation_2{[Schema = "dbo"]}[Data],
  TableNavigation = Navigation_3{[Name = "dim_store"]}?[Data]?
in
  TableNavigation;
shared agg_sales_by_customer_DataDestination = let
  Pattern = Fabric.Warehouse([CreateNavigationProperties = false, HierarchicalNavigation = true]),
  Navigation_1 = Pattern{[workspaceId = "."]}[Data],
  Navigation_2 = Navigation_1{[displayName = "Lab2_WH"]}[Data],
  Navigation_3 = Navigation_2{[Schema = "dbo"]}[Data],
  TableNavigation = Navigation_3{[Name = "agg_sales_by_customer"]}?[Data]?
in
  TableNavigation;
shared agg_sales_by_product_DataDestination = let
  Pattern = Fabric.Warehouse([CreateNavigationProperties = false, HierarchicalNavigation = true]),
  Navigation_1 = Pattern{[workspaceId = "."]}[Data],
  Navigation_2 = Navigation_1{[displayName = "Lab2_WH"]}[Data],
  Navigation_3 = Navigation_2{[Schema = "dbo"]}[Data],
  TableNavigation = Navigation_3{[Name = "agg_sales_by_product"]}?[Data]?
in
  TableNavigation;

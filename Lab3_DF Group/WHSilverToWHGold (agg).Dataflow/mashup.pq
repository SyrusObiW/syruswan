[StagingDefinition = [Kind = "FastCopy"]]
section Section1;
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

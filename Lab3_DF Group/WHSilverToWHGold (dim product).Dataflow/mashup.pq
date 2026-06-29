[StagingDefinition = [Kind = "FastCopy"]]
section Section1;
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "stg dim_product_DataDestination", IsNewTarget = true], Settings = [Kind = "Manual", AllowCreation = true, ColumnSettings = [Mappings = {[SourceColumnName = "product_key", DestinationColumnName = "product_key"], [SourceColumnName = "product_id", DestinationColumnName = "product_id"], [SourceColumnName = "product_name", DestinationColumnName = "product_name"], [SourceColumnName = "category", DestinationColumnName = "category"], [SourceColumnName = "subcategory", DestinationColumnName = "subcategory"], [SourceColumnName = "brand", DestinationColumnName = "brand"], [SourceColumnName = "cost_price", DestinationColumnName = "cost_price"], [SourceColumnName = "list_price", DestinationColumnName = "list_price"]}], DynamicSchema = false, UpdateMethod = [Kind = "Replace"], TypeSettings = [Kind = "Table"]]]}]
shared #"stg dim_product" = let
  來源 = Fabric.Warehouse(null),
  巡覽 = 來源{[workspaceId = "f42c5981-42e2-4f68-9985-cf204aaab82c"]}[Data],
  #"巡覽 1" = 巡覽{[warehouseId = "f70efe4c-20fc-4531-92be-1619a01cd29d"]}[Data],
  #"巡覽 2" = #"巡覽 1"{[Schema = "stg", Item = "dim_product"]}[Data]
in
  #"巡覽 2";
shared #"stg dim_product_DataDestination" = let
  Pattern = Fabric.Warehouse([CreateNavigationProperties = false, HierarchicalNavigation = true]),
  Navigation_1 = Pattern{[workspaceId = "."]}[Data],
  Navigation_2 = Navigation_1{[displayName = "Lab2_WH"]}[Data],
  Navigation_3 = Navigation_2{[Schema = "dbo"]}[Data],
  TableNavigation = Navigation_3{[Name = "dim_product"]}?[Data]?
in
  TableNavigation;

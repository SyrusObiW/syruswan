[StagingDefinition = [Kind = "FastCopy"]]
section Section1;
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "stg dim_store_DataDestination", IsNewTarget = true], Settings = [Kind = "Manual", AllowCreation = true, ColumnSettings = [Mappings = {[SourceColumnName = "store_key", DestinationColumnName = "store_key"], [SourceColumnName = "store_id", DestinationColumnName = "store_id"], [SourceColumnName = "store_name", DestinationColumnName = "store_name"], [SourceColumnName = "city", DestinationColumnName = "city"], [SourceColumnName = "country", DestinationColumnName = "country"], [SourceColumnName = "region", DestinationColumnName = "region"], [SourceColumnName = "store_type", DestinationColumnName = "store_type"], [SourceColumnName = "open_year", DestinationColumnName = "open_year"]}], DynamicSchema = false, UpdateMethod = [Kind = "Replace"], TypeSettings = [Kind = "Table"]]]}]
shared #"stg dim_store" = let
  來源 = Fabric.Warehouse(null),
  巡覽 = 來源{[workspaceId = "f42c5981-42e2-4f68-9985-cf204aaab82c"]}[Data],
  #"巡覽 1" = 巡覽{[warehouseId = "f70efe4c-20fc-4531-92be-1619a01cd29d"]}[Data],
  #"巡覽 2" = #"巡覽 1"{[Schema = "stg", Item = "dim_store"]}[Data]
in
  #"巡覽 2";
shared #"stg dim_store_DataDestination" = let
  Pattern = Fabric.Warehouse([CreateNavigationProperties = false, HierarchicalNavigation = true]),
  Navigation_1 = Pattern{[workspaceId = "."]}[Data],
  Navigation_2 = Navigation_1{[displayName = "Lab2_WH"]}[Data],
  Navigation_3 = Navigation_2{[Schema = "dbo"]}[Data],
  TableNavigation = Navigation_3{[Name = "dim_store"]}?[Data]?
in
  TableNavigation;

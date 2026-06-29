[DefaultOutputDestinationSettings = [DestinationDefinition = [Kind = "Reference", QueryName = "DefaultDestination", IsNewTarget = true], UpdateMethod = [Kind = "Append"], DestinationTypeSettings = [Kind = "Table"]], StagingDefinition = [Kind = "FastCopy"]]
section Section1;
shared DefaultDestination = Fabric.Warehouse([CreateNavigationProperties = false]){[workspaceId = "f42c5981-42e2-4f68-9985-cf204aaab82c"]}[Data]{[warehouseId = "f70efe4c-20fc-4531-92be-1619a01cd29d"]}[Data];
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "dim_customer_DataDestination", IsNewTarget = true], Settings = [Kind = "Manual", AllowCreation = true, ColumnSettings = [Mappings = {[SourceColumnName = "customer_key", DestinationColumnName = "customer_key"], [SourceColumnName = "customer_id", DestinationColumnName = "customer_id"], [SourceColumnName = "full_name", DestinationColumnName = "full_name"], [SourceColumnName = "email", DestinationColumnName = "email"], [SourceColumnName = "city", DestinationColumnName = "city"], [SourceColumnName = "country", DestinationColumnName = "country"], [SourceColumnName = "segment", DestinationColumnName = "segment"], [SourceColumnName = "created_date", DestinationColumnName = "created_date"]}], DynamicSchema = false, UpdateMethod = [Kind = "Replace"], TypeSettings = [Kind = "Table"]]]}]
shared dim_customer = let
  來源 = Lakehouse.Contents(null),
  巡覽 = 來源{[workspaceId = "f42c5981-42e2-4f68-9985-cf204aaab82c"]}[Data],
  #"巡覽 1" = 巡覽{[lakehouseId = "290beacc-ee3e-4811-b2ef-dc1157c70cd5"]}[Data],
  #"巡覽 2" = #"巡覽 1"{[Id = "dim_customer", ItemKind = "Table"]}[Data]
in
  #"巡覽 2";
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "dim_product_DataDestination", IsNewTarget = true], Settings = [Kind = "Manual", AllowCreation = true, ColumnSettings = [Mappings = {[SourceColumnName = "product_key", DestinationColumnName = "product_key"], [SourceColumnName = "product_id", DestinationColumnName = "product_id"], [SourceColumnName = "product_name", DestinationColumnName = "product_name"], [SourceColumnName = "category", DestinationColumnName = "category"], [SourceColumnName = "subcategory", DestinationColumnName = "subcategory"], [SourceColumnName = "brand", DestinationColumnName = "brand"], [SourceColumnName = "cost_price", DestinationColumnName = "cost_price"], [SourceColumnName = "list_price", DestinationColumnName = "list_price"]}], DynamicSchema = false, UpdateMethod = [Kind = "Replace"], TypeSettings = [Kind = "Table"]]]}]
shared dim_product = let
  來源 = Lakehouse.Contents(null),
  巡覽 = 來源{[workspaceId = "f42c5981-42e2-4f68-9985-cf204aaab82c"]}[Data],
  #"巡覽 1" = 巡覽{[lakehouseId = "290beacc-ee3e-4811-b2ef-dc1157c70cd5"]}[Data],
  #"巡覽 2" = #"巡覽 1"{[Id = "dim_product", ItemKind = "Table"]}[Data]
in
  #"巡覽 2";
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "dim_promotion_DataDestination", IsNewTarget = true], Settings = [Kind = "Manual", AllowCreation = true, ColumnSettings = [Mappings = {[SourceColumnName = "promotion_key", DestinationColumnName = "promotion_key"], [SourceColumnName = "promotion_name", DestinationColumnName = "promotion_name"], [SourceColumnName = "promotion_type", DestinationColumnName = "promotion_type"], [SourceColumnName = "discount_pct", DestinationColumnName = "discount_pct"], [SourceColumnName = "start_date", DestinationColumnName = "start_date"], [SourceColumnName = "end_date", DestinationColumnName = "end_date"]}], DynamicSchema = false, UpdateMethod = [Kind = "Replace"], TypeSettings = [Kind = "Table"]]]}]
shared dim_promotion = let
  來源 = Lakehouse.Contents(null),
  巡覽 = 來源{[workspaceId = "f42c5981-42e2-4f68-9985-cf204aaab82c"]}[Data],
  #"巡覽 1" = 巡覽{[lakehouseId = "290beacc-ee3e-4811-b2ef-dc1157c70cd5"]}[Data],
  #"巡覽 2" = #"巡覽 1"{[Id = "dim_promotion", ItemKind = "Table"]}[Data]
in
  #"巡覽 2";
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "dim_store_DataDestination", IsNewTarget = true], Settings = [Kind = "Manual", AllowCreation = true, ColumnSettings = [Mappings = {[SourceColumnName = "store_key", DestinationColumnName = "store_key"], [SourceColumnName = "store_id", DestinationColumnName = "store_id"], [SourceColumnName = "store_name", DestinationColumnName = "store_name"], [SourceColumnName = "city", DestinationColumnName = "city"], [SourceColumnName = "country", DestinationColumnName = "country"], [SourceColumnName = "region", DestinationColumnName = "region"], [SourceColumnName = "store_type", DestinationColumnName = "store_type"], [SourceColumnName = "open_year", DestinationColumnName = "open_year"]}], DynamicSchema = false, UpdateMethod = [Kind = "Replace"], TypeSettings = [Kind = "Table"]]]}]
shared dim_store = let
  來源 = Lakehouse.Contents(null),
  巡覽 = 來源{[workspaceId = "f42c5981-42e2-4f68-9985-cf204aaab82c"]}[Data],
  #"巡覽 1" = 巡覽{[lakehouseId = "290beacc-ee3e-4811-b2ef-dc1157c70cd5"]}[Data],
  #"巡覽 2" = #"巡覽 1"{[Id = "dim_store", ItemKind = "Table"]}[Data]
in
  #"巡覽 2";
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "fact_sales_DataDestination", IsNewTarget = true], Settings = [Kind = "Manual", AllowCreation = true, ColumnSettings = [Mappings = {[SourceColumnName = "sale_id", DestinationColumnName = "sale_id"], [SourceColumnName = "customer_id", DestinationColumnName = "customer_id"], [SourceColumnName = "product id", DestinationColumnName = "product id"], [SourceColumnName = "store_id", DestinationColumnName = "store_id"], [SourceColumnName = "promotion_id", DestinationColumnName = "promotion_id"], [SourceColumnName = "quantity", DestinationColumnName = "quantity"], [SourceColumnName = "unit_price", DestinationColumnName = "unit_price"], [SourceColumnName = "discount_amt", DestinationColumnName = "discount_amt"], [SourceColumnName = "revenue", DestinationColumnName = "revenue"], [SourceColumnName = "discount_pct", DestinationColumnName = "discount_pct"], [SourceColumnName = "sale_date_clean", DestinationColumnName = "sale_date_clean"]}], DynamicSchema = false, UpdateMethod = [Kind = "Replace"], TypeSettings = [Kind = "Table"]]]}]
shared fact_sales = let
  來源 = Lakehouse.Contents(null),
  巡覽 = 來源{[workspaceId = "f42c5981-42e2-4f68-9985-cf204aaab82c"]}[Data],
  #"巡覽 1" = 巡覽{[lakehouseId = "290beacc-ee3e-4811-b2ef-dc1157c70cd5"]}[Data],
  #"巡覽 2" = #"巡覽 1"{[Id = "fact_sales", ItemKind = "Table"]}[Data],
  #"a. 已重新命名資料行" = Table.RenameColumns(#"巡覽 2", {{"col_1", "sale_id"}, {"REVENUE", "revenue"}, {"Discount%", "discount_pct"}, {"Sale Date", "sale_date"}, {"Customer ID", "customer_id"}, {"Product ID", "product id"}, {"Store ID", "store_id"}, {"Promotion ID", "promotion_id"}, {"QTY", "quantity"}, {"Unit Price", "unit_price"}, {"Discount Amt", "discount_amt"}}),
  #"b. 取代USD 值" = Table.ReplaceValue(#"a. 已重新命名資料行", "USD ", "", Replacer.ReplaceText, {"revenue"}),
  #"b. 取代 $ 值" = Table.ReplaceValue(#"b. 取代USD 值", "$", "", Replacer.ReplaceText, {"revenue"}),
  #"b. 取代 nan 值" = Table.ReplaceValue(#"b. 取代 $ 值", "nan", "", Replacer.ReplaceText, {"revenue"}),
  #"c. 已移除重覆項目" = Table.Distinct(#"b. 取代 nan 值", {"sale_id", "sale_date", "customer_id", "product id", "store_id", "promotion_id", "quantity", "unit_price", "discount_amt", "revenue", "discount_pct"}),
  #"d. 轉換日期格式" = Table.AddColumn(#"c. 已移除重覆項目", "sale_date_clean", each
    let
      raw = [sale_date],
      parsed =
        try Date.From(DateTime.FromText(raw, [Culture = "en-US"]))
        otherwise try Date.FromText(raw, [Culture = "en-GB"])
        otherwise try Date.FromText(raw, [Culture = "en-US"])
        otherwise null
    in
      parsed
  , type date),
  已移除資料行 = Table.RemoveColumns(#"d. 轉換日期格式", {"sale_date"}),
  #"e. 已取代值" = Table.ReplaceValue(已移除資料行, null, 0, Replacer.ReplaceValue, {"quantity"}),
  已變更資料行類型 = Table.TransformColumnTypes(#"e. 已取代值", {{"revenue", type number}}),
  #"e. 已篩選資料列" = Table.SelectRows(已變更資料行類型, each ([customer_id] <> "") and ([product id] <> ""))
in
  #"e. 已篩選資料列";
shared dim_customer_DataDestination = let
  Pattern = Fabric.Warehouse([CreateNavigationProperties = false, HierarchicalNavigation = true]),
  Navigation_1 = Pattern{[workspaceId = "."]}[Data],
  Navigation_2 = Navigation_1{[displayName = "Lab2_WH"]}[Data],
  Navigation_3 = Navigation_2{[Schema = "stg"]}[Data],
  TableNavigation = Navigation_3{[Name = "dim_customer"]}?[Data]?
in
  TableNavigation;
shared dim_store_DataDestination = let
  Pattern = Fabric.Warehouse([CreateNavigationProperties = false, HierarchicalNavigation = true]),
  Navigation_1 = Pattern{[workspaceId = "."]}[Data],
  Navigation_2 = Navigation_1{[displayName = "Lab2_WH"]}[Data],
  Navigation_3 = Navigation_2{[Schema = "stg"]}[Data],
  TableNavigation = Navigation_3{[Name = "dim_store"]}?[Data]?
in
  TableNavigation;
shared fact_sales_DataDestination = let
  Pattern = Fabric.Warehouse([CreateNavigationProperties = false, HierarchicalNavigation = true]),
  Navigation_1 = Pattern{[workspaceId = "."]}[Data],
  Navigation_2 = Navigation_1{[displayName = "Lab2_WH"]}[Data],
  Navigation_3 = Navigation_2{[Schema = "stg"]}[Data],
  TableNavigation = Navigation_3{[Name = "fact_sales"]}?[Data]?
in
  TableNavigation;
shared dim_promotion_DataDestination = let
  Pattern = Fabric.Warehouse([CreateNavigationProperties = false, HierarchicalNavigation = true]),
  Navigation_1 = Pattern{[workspaceId = "."]}[Data],
  Navigation_2 = Navigation_1{[displayName = "Lab2_WH"]}[Data],
  Navigation_3 = Navigation_2{[Schema = "stg"]}[Data],
  TableNavigation = Navigation_3{[Name = "dim_promotion"]}?[Data]?
in
  TableNavigation;
shared dim_product_DataDestination = let
  Pattern = Fabric.Warehouse([CreateNavigationProperties = false, HierarchicalNavigation = true]),
  Navigation_1 = Pattern{[workspaceId = "."]}[Data],
  Navigation_2 = Navigation_1{[displayName = "Lab2_WH"]}[Data],
  Navigation_3 = Navigation_2{[Schema = "stg"]}[Data],
  TableNavigation = Navigation_3{[Name = "dim_product"]}?[Data]?
in
  TableNavigation;

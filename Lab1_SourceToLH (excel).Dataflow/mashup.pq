[StagingDefinition = [Kind = "FastCopy"]]
section Section1;
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "fact_sales_DataDestination", IsNewTarget = true], Settings = [Kind = "Automatic", TypeSettings = [Kind = "Table"]]]}]
shared fact_sales = let
  來源 = Csv.Document(File.Contents("C:/Data/For_Excel_User_Sales/fact_sales.csv"), [Delimiter = ",", Columns = 11, Encoding = 65001, QuoteStyle = QuoteStyle.None]),
  已升階標頭 = Table.PromoteHeaders(來源, [PromoteAllScalars = true]),
  已變更資料行類型 = Table.TransformColumnTypes(已升階標頭, {{"col_1", type text}, {"Sale Date", type text}, {"Customer ID", type text}, {"Product ID", type text}, {"Store ID", type text}, {"Promotion ID", type text}, {"QTY", Int64.Type}, {"Unit Price", type number}, {"Discount Amt", type number}, {"REVENUE", type text}, {"Discount%", Int64.Type}}, "zh-Hant")
in
  已變更資料行類型;
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "dim_store_DataDestination", IsNewTarget = true], Settings = [Kind = "Manual", AllowCreation = true, ColumnSettings = [Mappings = {[SourceColumnName = "store_key", DestinationColumnName = "store_key"], [SourceColumnName = "store_id", DestinationColumnName = "store_id"], [SourceColumnName = "store_name", DestinationColumnName = "store_name"], [SourceColumnName = "city", DestinationColumnName = "city"], [SourceColumnName = "country", DestinationColumnName = "country"], [SourceColumnName = "region", DestinationColumnName = "region"], [SourceColumnName = "store_type", DestinationColumnName = "store_type"], [SourceColumnName = "open_year", DestinationColumnName = "open_year"]}], DynamicSchema = true, UpdateMethod = [Kind = "Replace"], TypeSettings = [Kind = "Table"]]]}]
shared dim_store = let
  來源 = Csv.Document(File.Contents("C:\Data\For_Excel_User_Sales\dim_store.csv"), [Delimiter = ",", Columns = 8, QuoteStyle = QuoteStyle.None]),
  已升階標頭 = Table.PromoteHeaders(來源, [PromoteAllScalars = true]),
  已變更資料行類型 = Table.TransformColumnTypes(已升階標頭, {{"store_key", Int64.Type}, {"store_id", type text}, {"store_name", type text}, {"city", type text}, {"country", type text}, {"region", type text}, {"store_type", type text}, {"open_year", Int64.Type}}, "zh-Hant")
in
  已變更資料行類型;
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "dim_promotion_DataDestination", IsNewTarget = true], Settings = [Kind = "Automatic", TypeSettings = [Kind = "Table"]]]}]
shared dim_promotion = let
  來源 = Csv.Document(File.Contents("C:\Data\For_Excel_User_Sales\dim_promotion.csv"), [Delimiter = ",", Columns = 6, QuoteStyle = QuoteStyle.None]),
  已升階標頭 = Table.PromoteHeaders(來源, [PromoteAllScalars = true]),
  已變更資料行類型 = Table.TransformColumnTypes(已升階標頭, {{"promotion_key", Int64.Type}, {"promotion_name", type text}, {"promotion_type", type text}, {"discount_pct", Int64.Type}, {"start_date", type date}, {"end_date", type date}}, "zh-Hant")
in
  已變更資料行類型;
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "dim_product_DataDestination", IsNewTarget = true], Settings = [Kind = "Automatic", TypeSettings = [Kind = "Table"]]]}]
shared dim_product = let
  來源 = Csv.Document(File.Contents("C:\Data\For_Excel_User_Sales\dim_product.csv"), [Delimiter = ",", Columns = 8, QuoteStyle = QuoteStyle.None]),
  已升階標頭 = Table.PromoteHeaders(來源, [PromoteAllScalars = true]),
  已變更資料行類型 = Table.TransformColumnTypes(已升階標頭, {{"product_key", Int64.Type}, {"product_id", type text}, {"product_name", type text}, {"category", type text}, {"subcategory", type text}, {"brand", type text}, {"cost_price", Int64.Type}, {"list_price", Int64.Type}}, "zh-Hant")
in
  已變更資料行類型;
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "dim_customer_DataDestination", IsNewTarget = false], Settings = [Kind = "Manual", AllowCreation = false, ColumnSettings = [Mappings = {[SourceColumnName = "customer_key", DestinationColumnName = "customer_key"], [SourceColumnName = "customer_id", DestinationColumnName = "customer_id"], [SourceColumnName = "full_name", DestinationColumnName = "full_name"], [SourceColumnName = "email", DestinationColumnName = "email"], [SourceColumnName = "city", DestinationColumnName = "city"], [SourceColumnName = "country", DestinationColumnName = "country"], [SourceColumnName = "segment", DestinationColumnName = "segment"], [SourceColumnName = "created_date", DestinationColumnName = "created_date"]}], DynamicSchema = false, UpdateMethod = [Kind = "Replace"], TypeSettings = [Kind = "Table"]]]}]
shared dim_customer = let
  來源 = Csv.Document(File.Contents("C:\Data\For_Excel_User_Sales\dim_customer.csv"), [Delimiter = ",", Columns = 8, QuoteStyle = QuoteStyle.None]),
  已升階標頭 = Table.PromoteHeaders(來源, [PromoteAllScalars = true]),
  已變更資料行類型 = Table.TransformColumnTypes(已升階標頭, {{"customer_key", Int64.Type}, {"customer_id", type text}, {"full_name", type text}, {"email", type text}, {"city", type text}, {"country", type text}, {"segment", type text}, {"created_date", type date}}, "zh-Hant")
in
  已變更資料行類型;
shared dim_store_DataDestination = let
  Pattern = Lakehouse.Contents([CreateNavigationProperties = false, EnableFolding = false, HierarchicalNavigation = true, EnableVorder = true, OutputMetadataRefresh = true]),
  Navigation_1 = Pattern{[workspaceId = "f42c5981-42e2-4f68-9985-cf204aaab82c"]}[Data],
  Navigation_2 = Navigation_1{[lakehouseId = "290beacc-ee3e-4811-b2ef-dc1157c70cd5"]}[Data],
  Navigation_3 = Navigation_2{[Id = "dbo", ItemKind = "Schema"]}[Data],
  TableNavigation = Navigation_3{[Id = "dim_store", ItemKind = "Table"]}?[Data]?
in
  TableNavigation;
shared dim_promotion_DataDestination = let
  Pattern = Lakehouse.Contents([CreateNavigationProperties = false, EnableFolding = false, HierarchicalNavigation = true, EnableVorder = true, OutputMetadataRefresh = true]),
  Navigation_1 = Pattern{[workspaceId = "f42c5981-42e2-4f68-9985-cf204aaab82c"]}[Data],
  Navigation_2 = Navigation_1{[lakehouseId = "290beacc-ee3e-4811-b2ef-dc1157c70cd5"]}[Data],
  Navigation_3 = Navigation_2{[Id = "dbo", ItemKind = "Schema"]}[Data],
  TableNavigation = Navigation_3{[Id = "dim_promotion", ItemKind = "Table"]}?[Data]?
in
  TableNavigation;
shared dim_product_DataDestination = let
  Pattern = Lakehouse.Contents([CreateNavigationProperties = false, EnableFolding = false, HierarchicalNavigation = true, EnableVorder = true, OutputMetadataRefresh = true]),
  Navigation_1 = Pattern{[workspaceId = "f42c5981-42e2-4f68-9985-cf204aaab82c"]}[Data],
  Navigation_2 = Navigation_1{[lakehouseId = "290beacc-ee3e-4811-b2ef-dc1157c70cd5"]}[Data],
  Navigation_3 = Navigation_2{[Id = "dbo", ItemKind = "Schema"]}[Data],
  TableNavigation = Navigation_3{[Id = "dim_product", ItemKind = "Table"]}?[Data]?
in
  TableNavigation;
shared dim_customer_DataDestination = let
  Pattern = Lakehouse.Contents([CreateNavigationProperties = false, EnableFolding = false, HierarchicalNavigation = true, EnableVorder = true, OutputMetadataRefresh = true]),
  Navigation_1 = Pattern{[workspaceId = "f42c5981-42e2-4f68-9985-cf204aaab82c"]}[Data],
  Navigation_2 = Navigation_1{[lakehouseId = "290beacc-ee3e-4811-b2ef-dc1157c70cd5"]}[Data],
  Navigation_3 = Navigation_2{[Id = "dbo", ItemKind = "Schema"]}[Data],
  TableNavigation = Navigation_3{[Id = "dim_customer", ItemKind = "Table"]}[Data]
in
  TableNavigation;
shared fact_sales_DataDestination = let
  Pattern = Lakehouse.Contents([CreateNavigationProperties = false, EnableFolding = false, HierarchicalNavigation = true, EnableVorder = true, OutputMetadataRefresh = true]),
  Navigation_1 = Pattern{[workspaceId = "f42c5981-42e2-4f68-9985-cf204aaab82c"]}[Data],
  Navigation_2 = Navigation_1{[lakehouseId = "290beacc-ee3e-4811-b2ef-dc1157c70cd5"]}[Data],
  Navigation_3 = Navigation_2{[Id = "dbo", ItemKind = "Schema"]}[Data],
  TableNavigation = Navigation_3{[Id = "fact_sales", ItemKind = "Table"]}?[Data]?
in
  TableNavigation;

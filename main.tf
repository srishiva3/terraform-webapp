resource "azurerm_resource_group" "example" {
  name     = "my_resource_group"  # Replace with your resource group name
  location = "East US2"  # Replace with your desired location
}

resource "azurerm_mysql_flexible_server" "example" {
  name                = "myrevhireserver"  # Replace with your MySQL server name
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  administrator_login = "admim11"  # Replace with your desired admin username
  administrator_password = "Welcome!11"  # Replace with your desired admin password

  create_mode = "Default"
  sku_name    = "B_Standard_B1s"  # Specify the desired SKU name here
  version     = "8.0.21"
  
  tags = {
    environment = "development"
  }
}



resource "azurerm_mysql_flexible_database" "example" {
  name                = "my-database"  # Replace with your database name
  resource_group_name = azurerm_resource_group.example.name
  server_name         = azurerm_mysql_flexible_server.example.name
  collation           = "utf8mb4_general_ci"
  charset             = "utf8mb4"
}

resource "azurerm_service_plan" "example" {
  name                = "my-app-service-plan"  # Replace with your app service plan name
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  sku_name            = "B1"  # Example, replace with the appropriate SKU name
  os_type             = "Linux"  # Example, replace with the appropriate OS type
}

resource "azurerm_app_service" "example" {
  name                = "revhireappservice1909"  # Replace with your app service name
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  app_service_plan_id = azurerm_service_plan.example.id

  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE" = "1"
  }

  site_config {
    always_on = true
  }

  lifecycle {
    ignore_changes = [
      app_settings["WEBSITE_RUN_FROM_PACKAGE"]
    ]
  }
}

resource "azurerm_static_web_app" "example" {
  name                = "revhirestatic"  # Replace with your static web app name
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
}

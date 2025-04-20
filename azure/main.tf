provider "azurerm" {
  features {}
}

# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "${var.function_name}-rg"
  location = var.location
}

# Storage Account for Function App
resource "azurerm_storage_account" "storage" {
  name                     = "${var.function_name}sa"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  allow_nested_items_to_be_public = false
}

# App Service Plan
resource "azurerm_app_service_plan" "plan" {
  name                = "${var.function_name}-plan"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  kind                = "FunctionApp"

  sku {
    tier = var.plan_type == "Consumption" ? "Dynamic" : "ElasticPremium"
    size = var.plan_type == "Consumption" ? "Y1" : "EP1"
  }

  reserved = var.runtime == "node" || var.runtime == "python"
}

# Function App
resource "azurerm_linux_function_app" "function" {
  name                = var.function_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_app_service_plan.plan.id
  storage_account_name = azurerm_storage_account.storage.name
  storage_account_access_key = azurerm_storage_account.storage.primary_access_key

  identity {
    type = "SystemAssigned"
  }

  app_settings = {
    FUNCTIONS_WORKER_RUNTIME = var.runtime
    WEBSITE_RUN_FROM_PACKAGE = var.function_code_path
    FUNCTION_APP_EDIT_MODE   = "readonly"
    ALWAYS_ON               = var.always_on ? "true" : "false"
    FUNCTION_APP_MEMORY     = tostring(var.memory_mb)
    FUNCTION_APP_TIMEOUT    = tostring(var.timeout_seconds)
  }

  site_config {
    always_on       = var.always_on
    ftps_state      = "Disabled"
    linux_fx_version = var.runtime == "node" ? "NODE|14" : var.runtime
  }
}

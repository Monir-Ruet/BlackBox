# Azure Log Analytics Workspace (ALAW)
resource "azurerm_log_analytics_workspace" "example" {
  name                = var.container_log_analytics_workspace
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
  tags = {
    environment = "dev"
  }
}

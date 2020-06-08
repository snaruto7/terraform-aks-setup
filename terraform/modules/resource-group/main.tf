resource "azurerm_resource_group" "aks-setup" {
  name     = var.rg_name
  location = var.location
}

terraform {
  backend "azurerm" {
    resource_group_name  = "tstate"
    storage_account_name = "STORAGE_ACC_NAME"
    container_name       = "CONTAINER_NAME"
    key                  = "terraform.tfstate"
    access_key           = "ACCESS_KEY"
  }
}
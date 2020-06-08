data "terraform_remote_state" "remote-state" {
  backend = "azurerm"
  config = {
    storage_account_name = "STORAGE_ACC_NAME"
    container_name       = "CONTAINER_NAME"
    key                  = "terraform.tfstate"
    access_key = "ACCESS_KEY"
  }
}
module "resource-group" {
  source   = "./modules/resource-group"
  rg_name  = var.rg_name
  location = var.resource_group_location
}

module "kube" {
  source        = "./modules/kubernetes-cluster"
  rg_name       = module.resource-group.rg_name
  location      = module.resource-group.rg-location
  cluster-name  = var.cluster-name
  dns_prefix    = var.dns_prefix
  node_count    = var.node_count
  k8s_vm        = var.k8s_vm
  client_id     = var.client_id
  client_secret = var.client_secret
  environment   = var.environment
}

module "acr" {
  source        = "./modules/acr"
  rg_name       = module.resource-group.rg_name
  location      = module.resource-group.rg-location
  name          = var.reg_name
}

module "keyvault" {
  source        = "./modules/keyvault"
  rg_name       = module.resource-group.rg_name
  location      = module.resource-group.rg-location
  name          = var.key_vault_name
  tenant_id     = data.azurerm_client_config.current.tenant_id
  object_id     = data.azurerm_client_config.current.object_id
}

resource "azurerm_key_vault_secret" "example" {
  name         = "kube-config"
  value        = module.kube.kube_config_raw
  key_vault_id = module.keyvault.id
}
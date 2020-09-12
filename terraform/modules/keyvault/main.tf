resource "azurerm_key_vault" "example" {
  name                        = var.name
  location                    = var.location
  resource_group_name         = var.rg_name
  enabled_for_disk_encryption = true
  tenant_id                   = var.tenant_id
  soft_delete_enabled         = true
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = var.tenant_id
    object_id = var.object_id

    key_permissions = [
      "get",
      "list",
      "update",
      "create",
      "import",
      "delete",
      "recover",
      "backup",
      "restore",
    ]

    secret_permissions = [
      "get",
      "list",
      "set",
      "delete",
      "recover",
      "backup",
      "restore",
    ]

    certificate_permissions = [
      "get",
      "list",
      "update",
      "create",
      "import",
      "delete",
      "recover",
      "backup",
      "restore",
      "managecontacts",
    ]

    storage_permissions = [
      "get",
      "list",
      "recover",
      "restore",
      "update",
      "backup",
      "delete",
      "set",
    ]
  }

  network_acls {
    default_action = "Deny"
    bypass         = "AzureServices"
    virtual_network_subnet_ids = ["/subscriptions/9b72cb19-80e0-4706-8ea1-1c14802e02a4/resourceGroups/self-prac/providers/Microsoft.Network/virtualNetworks/self-prac-vnet/subnets/default"]
  }
}
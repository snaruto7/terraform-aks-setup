variable name {
  type        = string
  description = "Name of Azure Key vault"
}

variable location {
  type        = string
  description = "Location of Azure Key vault"
}

variable rg_name {
  type        = string
  description = "Name of resource group"
}

variable tenant_id {
  type        = string
  description = "Tenant Id of selected subscription"
}

variable object_id {
  type        = string
  description = "Object Id of selected subscription"
}

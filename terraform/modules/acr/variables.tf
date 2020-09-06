variable name {
  type        = string
  description = "Name of the registry"
}
variable "rg_name" {
  description = "Name of resource group containing k8s cluster"
}
variable "location" {
  description = "Location of k8s cluster resource group"
}
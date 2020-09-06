variable "subscription_id" {
  description = "This is default subscription ID to be used"
}
variable "client_id" {
  description = "This is client id to be used"
}
variable "client_secret" {
  description = "This is the client secret of defined client_id"
}
variable "tenant_id" {
  description = "This is the tenant id"
}


variable "rg_name" {
  description = "Name of resource group"
}
variable "resource_group_location" {
  description = "Location of resource group"
}
variable "environment" {
  description = "Definition of tags"
}



variable "cluster-name" {
  description = "Name of kubernetes cluster"
}
variable "dns_prefix" {
  description = "Prefix of domain name"
}
variable "node_count" {
  description = "Initial number of nodes in cluster"
}
variable "k8s_vm" {
  description = "Size of each vm for nodes in cluster"
}

variable reg_name {
  type        = string
  description = "Name of the registry"
}

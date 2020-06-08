variable "rg_name" {
  description = "Name of resource group containing k8s cluster"
}
variable "location" {
  description = "Location of k8s cluster resource group"
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
variable "environment" {
  description = "Env value for tags"
}
variable "client_id" {
  description = "client ID from azure active directory"
}
variable "client_secret" {
  description = "client secret for that client id"
}

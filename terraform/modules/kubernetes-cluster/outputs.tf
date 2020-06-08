output "clientZ_certificate" {
  value = azurerm_kubernetes_cluster.kube-cluster.kube_config.0.client_certificate
}
output "kube_config_raw" {
  value = azurerm_kubernetes_cluster.kube-cluster.kube_config_raw
}


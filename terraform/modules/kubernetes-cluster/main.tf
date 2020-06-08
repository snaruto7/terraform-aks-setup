resource "azurerm_kubernetes_cluster" "kube-cluster" {
    name  = var.cluster-name
    location = var.location
    resource_group_name = var.rg_name
    dns_prefix   = var.dns_prefix

    default_node_pool {
        name       = "default"
        node_count = var.node_count
        vm_size    = var.k8s_vm
    }

    service_principal {
        client_id = var.client_id
        client_secret = var.client_secret
    }

    tags = {
        env = var.environment
    }

}

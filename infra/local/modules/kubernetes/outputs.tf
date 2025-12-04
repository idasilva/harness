output "cluster_name" {
  description = "Name of the Kind cluster"
  value       = var.cluster_name
}

output "cluster_endpoint" {
  description = "Kubernetes API endpoint"
  value       = data.external.cluster_info.result.server
}

output "cluster_ca_data" {
  description = "Cluster CA certificate"
  value       = data.external.cluster_info.result.ca_data
  sensitive   = true
}

output "cluster_token" {
  description = "Service account token for cluster access"
  value       = data.external.cluster_info.result.token
  sensitive   = true
}

output "kubectl_context" {
  description = "kubectl context name"
  value       = "kind-${var.cluster_name}"
}

output "kubeconfig_path" {
  description = "Path to kubeconfig"
  value       = "~/.kube/config"
}
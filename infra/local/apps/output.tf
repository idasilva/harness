output "cluster_name" {
  description = "Cluster name"
  value       = module.kubernetes.cluster_name
}

output "cluster_endpoint" {
  description = "Cluster endpoint"
  value       = module.kubernetes.cluster_endpoint
}

output "kubectl_context" {
  description = "kubectl context"
  value       = module.kubernetes.kubectl_context
}

output "cluster_ca_data" {
  description = "Cluster CA data"
  value       = module.kubernetes.cluster_ca_data
  sensitive   = true
}

output "cluster_token" {
  description = "Cluster token"
  value       = module.kubernetes.cluster_token
  sensitive   = true
}

output "access_instructions" {
  description = "How to access the cluster"
  value       = <<-EOT
    Cluster created successfully!
    
    To access the cluster:
      kubectl config use-context ${module.kubernetes.kubectl_context}
      kubectl get nodes
    
    Cluster info available in Terraform state for apps/team-* to use.
  EOT
}
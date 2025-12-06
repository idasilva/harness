output "namespace" {
  description = "Namespace where ngrok operator is installed"
  value       = var.create_namespace ? kubernetes_namespace.ngrok[0].metadata[0].name : var.namespace
}

output "release_name" {
  description = "Helm release name"
  value       = helm_release.ngrok_operator.name
}

output "release_status" {
  description = "Helm release status"
  value       = helm_release.ngrok_operator.status
}

output "chart_version" {
  description = "Installed chart version"
  value       = helm_release.ngrok_operator.metadata[0].version
}
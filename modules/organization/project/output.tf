output "project_id" {
  description = "The ID of the created project"
  value       = harness_platform_project.ck_project.id
}

output "project_identifier" {
  description = "The identifier of the created project"
  value       = harness_platform_project.ck_project.identifier
}

output "project_name" {
  description = "The name of the created project"
  value       = harness_platform_project.ck_project.name
}

output "organization_id" {
  description = "The organization ID the project belongs to"
  value       = harness_platform_project.ck_project.org_id
}

output "gitops_agent_id" {
  description = "GitOps Agent ID"
  value       = var.enable_gitops ? harness_platform_gitops_agent.agent[0].id : null
}

output "gitops_agent_identifier" {
  description = "GitOps Agent Identifier"
  value       = var.enable_gitops ? harness_platform_gitops_agent.agent[0].identifier : null
}

output "gitops_repository_id" {
  description = "GitOps Repository ID"
  value       = var.enable_gitops && var.github_repo != "" ? harness_platform_gitops_repository.repo[0].id : null
}

output "gitops_cluster_id" {
  description = "GitOps Cluster ID"
  value       = var.enable_gitops ? harness_platform_gitops_cluster.cluster[0].id : null
}
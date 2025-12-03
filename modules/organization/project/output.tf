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

output "pr_trigger_id" {
  description = "PR trigger identifier"
  value       = harness_platform_triggers.pr_trigger.identifier
}

output "pr_trigger_name" {
  description = "PR trigger name"
  value       = harness_platform_triggers.pr_trigger.name
}

output "pr_trigger_url" {
  description = "URL to view PR trigger in Harness UI"
  value       = "https://app.harness.io/ng/account/${var.account_id}/home/orgs/${var.organization_id}/projects/${harness_platform_project.ck_project.id}/triggers/${harness_platform_triggers.pr_trigger.identifier}"
}

output "pr_trigger_webhook_url" {
  description = "Webhook URL for GitHub (if using webhook trigger)"
  value       = "https://app.harness.io/gateway/ng/api/webhook/custom/${var.account_id}/${var.organization_id}/${harness_platform_project.ck_project.id}/${harness_platform_triggers.pr_trigger.identifier}"
}

output "pr_trigger_target_pipeline" {
  description = "Pipeline that this trigger targets"
  value       = harness_platform_triggers.pr_trigger.target_id
}

output "pr_trigger_enabled" {
  description = "Whether the trigger is enabled"
  value       = true
}
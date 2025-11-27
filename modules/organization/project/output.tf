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
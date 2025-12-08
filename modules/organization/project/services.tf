resource "harness_platform_service" "helm_service" {
  for_each = local.service_env_map

  identifier = each.value.key
  name       = "${each.value.svc_name}_${each.value.env_key}"
  org_id     = var.organization_id
  project_id = harness_platform_project.ck_project.id

  yaml = templatefile("${path.module}/templates/tracked-based-${each.value.svc_type}-github/services/devops-helm-services-${each.value.env_key}.yaml", {
    service_name    = each.value.svc_name
    service_id      = each.value.key
    env_key       = each.value.env_key   
    repo_name       = each.value.repo_name
    folder_path     = each.value.folder_path
    branch          = each.value.branch
    values_file     = each.value.values_file
    connector_ref   = var.github_connector_ref
    org_id          = var.organization_id
    project_id      = harness_platform_project.ck_project.id
  })

  tags = [
    for k, v in var.tags : "${k}:${v}"
  ]

  depends_on = [
    harness_platform_environment.environment
  ]
}
resource "harness_platform_environment" "environment" {
  for_each   = local.environments
  identifier = each.key
  name       = each.value.name
  org_id     = var.organization_id
  project_id = var.project
  type       = each.value.type
  tags = [
    for k, v in var.tags : "${k}:${v}"
  ]
}

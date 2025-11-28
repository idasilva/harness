resource "harness_platform_project" "ck_project" {
  identifier  = lower(replace(var.project, "-", ""))
  name        = var.project
  org_id      = var.organization_id
  color       = var.color
  description = var.description
  tags = [
    for k, v in var.tags : "${k}:${v}"
  ]
}

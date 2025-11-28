module "project" {
  source = "./project"
  
  for_each = var.projects

  project      = each.value.project_name
  organization_id   = lower(replace(var.organization, "-", ""))
  tags = var.tags

  depends_on = [
    harness_platform_organization.ck_org
  ]
}
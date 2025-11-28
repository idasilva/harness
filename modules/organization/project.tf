module "project" {
  source = "./project"
  
  for_each = toset(var.projects)

  project      = each.value
  organization_id   = lower(replace(var.organization, "-", ""))
  tags = var.tags

  depends_on = [
    harness_platform_organization.ck_org
  ]
}
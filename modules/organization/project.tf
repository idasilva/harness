module "project" {
  source = "./project"
  
  for_each = var.projects1

  project_name      = each.value.project_name
  organization_id   = lower(replace(var.organization, "-", ""))
  platform_api_key  = var.platform_api_key
  account_id        = var.account_id
  organization_name = var.organization
  organization_unit = var.organization_unit
  kubernetes_clusters = var.kubernetes_clusters

  depends_on = [
    harness_platform_organization.ck_org
  ]
}
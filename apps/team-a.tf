module "project-team-a" {
  source = "../modules/organization"

  organization      = var.organization
  organization_unit = var.organization_unit
  projects          = var.projects
  platform_api_key  = var.platform_api_key
  account_id        = var.account_id
  tags              = module.workspace-team-a.default_tags
}


module "workspace-team-a" {
  source = "../modules/workspace"
  name   = terraform.workspace
}

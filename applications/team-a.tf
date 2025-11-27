module "project-team-a" {
  source = "./modules/organization"

  organization      = "team-a-org"
  organization_unit = "team-a-dept"
  projects          = ["project1", "project2", "project3"]
  platform_api_key  = var.platform_api_key
  account_id        = var.account_id
  tags              = module.workspace.default_tags
}


module "workspace-team-a" {
  source = "../modules/workspace"
  name   = terraform.workspace
}

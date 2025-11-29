module "project-team-a" {
  source = "../modules/organization"

  organization      = var.organization
  organization_unit = var.organization_unit
  projects          = var.projects
  account_id        = var.account_id
  use_default_org   = var.use_default_org

  secrets    = var.secrets
  connectors = var.connectors
  create_connectors_for_projects = var.projects

  enable_gitops  = var.enable_gitops
  gitops_config  = var.gitops_config

  tags = module.workspace-team-a.default_tags
}

module "workspace-team-a" {
  source = "../modules/workspace"
  name   = terraform.workspace
}

locals {
  # If projects is a list, convert to set; if map, use keys
  projects_with_connectors = length(var.create_connectors_for_projects) > 0 ? var.create_connectors_for_projects : toset(var.projects)
}

# Create connectors for specified projects
module "connectors" {
  source   = "./connectors"
  for_each = toset(local.projects_with_connectors)

  organization_id = local.organization_id
  project_id      = module.project[each.key].project_id

  secrets    = var.secrets
  connectors = var.connectors

  default_tags = var.tags

  depends_on = [module.project]
}
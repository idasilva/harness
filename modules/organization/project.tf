module "project" {
  source = "./project"

  for_each = toset(var.projects)

  project         = each.value
  organization_id = lower(replace(var.organization, "-", ""))
  tags            = var.tags
  account_id      = var.account_id

  enable_gitops = var.enable_gitops
  gitops_config = var.gitops_config
  github_repo = var.github_repo

  depends_on = [
    harness_platform_organization.ck_org
  ]
}

data "harness_platform_gitops_agent_deploy_yaml" "gitops_agent_yaml" {
  count = var.enable_gitops ? 1 : 0

  identifier = harness_platform_gitops_agent.agent[0].identifier

  project_id = var.project
  org_id     = var.organization_id
  namespace  = var.gitops_config.agent_namespace

  depends_on = [harness_platform_gitops_agent.agent]
}

data "harness_platform_gitops_agent_operator_yaml" "gitops_operator_yaml" {
  count = var.enable_gitops ? 1 : 0

  identifier = harness_platform_gitops_agent.agent[0].identifier
  project_id = var.project
  org_id     = var.organization_id
  namespace  = var.gitops_config.agent_namespace
  skip_crds  = false

  depends_on = [harness_platform_gitops_agent.agent]
}

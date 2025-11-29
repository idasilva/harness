resource "local_file" "gitops_operator_yaml_file" {
  count = var.enable_gitops ? 1 : 0

  filename = "${path.module}/gitops_operator_${var.project}.yaml"
  content  = data.harness_platform_gitops_agent_operator_yaml.gitops_operator_yaml[0].yaml

  lifecycle {
    ignore_changes = [content]
  }
}

resource "local_file" "gitops_agent_yaml_file" {
  count = var.enable_gitops ? 1 : 0

  filename = "${path.module}/gitops_agent_${var.project}.yaml"
  content  = data.harness_platform_gitops_agent_deploy_yaml.gitops_agent_yaml[0].yaml
  lifecycle {
    ignore_changes = [content]
  }
}

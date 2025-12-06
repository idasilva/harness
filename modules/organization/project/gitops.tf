resource "harness_platform_gitops_agent" "agent" {
  count = var.enable_gitops ? 1 : 0

  identifier = "${var.project}_gitops_agent"
  project_id = var.project
  org_id     = var.organization_id
  name       = "${var.project}-gitops-agent"
  type       = "MANAGED_ARGO_PROVIDER"
  operator   = "ARGO"

  metadata {
    namespace         = var.gitops_config.agent_namespace
    high_availability = var.gitops_config.high_availability
  }

  depends_on = [harness_platform_project.ck_project]
}


resource "kubectl_manifest" "gitops_namespace" {
  count = var.enable_gitops ? 1 : 0

  yaml_body = <<-YAML
    apiVersion: v1
    kind: Namespace
    metadata:
      name: ${var.gitops_config.agent_namespace}
  YAML

  server_side_apply = true
  force_conflicts   = true
}

resource "null_resource" "deploy_operator_to_cluster" {
  count = var.enable_gitops ? 1 : 0

  triggers = {
    content      = local_file.gitops_operator_yaml_file[0].content
    # file_id      = local_file.gitops_operator_yaml_file[0].id
    # manifest_md5 = md5(data.harness_platform_gitops_agent_operator_yaml.gitops_operator_yaml[0].yaml)
    # agent_identifier = harness_platform_gitops_agent.agent[0].identifier
  }

  provisioner "local-exec" {
    when    = create
    command = "kubectl apply -f ${local_file.gitops_operator_yaml_file[0].filename}; sleep 120"
  }

  depends_on = [local_file.gitops_operator_yaml_file]
}

resource "null_resource" "deploy_agent_to_cluster" {
  count = var.enable_gitops ? 1 : 0

  triggers = {
    content      = local_file.gitops_agent_yaml_file[0].content
    # file_id      = local_file.gitops_agent_yaml_file[0].id
    # manifest_md5 = md5(data.harness_platform_gitops_agent_deploy_yaml.gitops_agent_yaml[0].yaml)
    # operator_id  = null_resource.deploy_operator_to_cluster[0].id
    # agent_identifier = harness_platform_gitops_agent.agent[0].identifier
  }

  provisioner "local-exec" {
    when    = create
    command = "kubectl apply -f ${local_file.gitops_agent_yaml_file[0].filename}; sleep 120"
  }

  depends_on = [
    local_file.gitops_agent_yaml_file,
    null_resource.deploy_operator_to_cluster
  ]
}

resource "harness_platform_gitops_repository" "repo" {
  count = var.enable_gitops && var.github_repo != "" ? 1 : 0

  identifier = "${var.project}_gitops_repo"
  project_id = var.project
  org_id     = var.organization_id
  agent_id   = "${var.project}_gitops_agent"

  repo {
    repo            = "https://github.com/${var.github_repo}"
    name            = "${var.project}-repo"
    insecure        = false
    connection_type = "HTTPS_ANONYMOUS"
  }

  upsert = true

  depends_on = [harness_platform_gitops_agent.agent]
}

resource "harness_platform_gitops_cluster" "cluster" {
  count = var.enable_gitops ? 1 : 0

  identifier = "${var.project}_k8s_cluster"
  project_id = var.project
  org_id     = var.organization_id
  agent_id   = harness_platform_gitops_agent.agent[0].id

  request {
    upsert = true
    cluster {
      server = var.gitops_config.cluster_server
      name   = var.gitops_config.cluster_name
      config {
        tls_client_config {
          insecure = false
        }
        cluster_connection_type = "IN_CLUSTER"
      }
    }
  }

  depends_on = [harness_platform_gitops_agent.agent, kubectl_manifest.gitops_namespace, null_resource.deploy_agent_to_cluster, null_resource.deploy_operator_to_cluster]
}

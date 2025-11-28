resource "harness_platform_gitops_agent" "agent" {
  count = var.enable_gitops ? 1 : 0

  identifier = "${var.project}_gitops_agent"
  project_id = var.project
  org_id     = var.organization_id
  name       = "${var.project}-gitops-agent"
  type       = "MANAGED_ARGO_PROVIDER"
  
  metadata {
    namespace         = var.gitops_config.agent_namespace
    high_availability = var.gitops_config.high_availability
  }

  depends_on = [harness_platform_project.ck_project]
}

resource "harness_platform_gitops_repository" "repo" {
  count = var.enable_gitops && var.github_repo != "" ? 1 : 0

  identifier = "${var.project}_gitops_repo"
  project_id = var.project
  org_id     = var.organization_id
  agent_id   = harness_platform_gitops_agent.agent[0].id
  
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

  depends_on = [harness_platform_gitops_agent.agent]
}
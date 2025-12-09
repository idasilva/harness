resource "harness_platform_infrastructure" "k8s_infra" {
  for_each = local.environments

  identifier      = "k8s_${each.key}"
  name            = "Kubernetes ${each.value.name}"
  org_id          = var.organization_id
  project_id      = harness_platform_project.ck_project.id
  env_id          = harness_platform_environment.environment[each.key].id
  type            = "KubernetesDirect"
  deployment_type = "NativeHelm"

  yaml = templatefile("${path.module}/templates/tracked-based-go-github/infrastructure/${each.key}-infrastructure.yaml", {
    infra_name      = "Kubernetes ${each.value.name}"
    infra_id        = "k8s_${each.key}"
    env_ref         = each.key
    namespace       = each.value.namespace
    connector_ref   = var.k8s_connector_ref
    org_id          = var.organization_id
    project_id      = harness_platform_project.ck_project.id
  })

  depends_on = [
    harness_platform_environment.environment
  ]
}
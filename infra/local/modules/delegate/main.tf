resource "helm_release" "harness_delegate" {
  name             = var.delegate_name
  repository       = "https://app.harness.io/storage/harness-download/delegate-helm-chart/"
  chart            = "harness-delegate-ng"
  namespace        = var.namespace
  create_namespace = true

  set {
    name  = "delegateName"
    value = var.delegate_name
  }

  set {
    name  = "accountId"
    value = var.account_id
  }

  set {
    name  = "delegateToken"
    value = var.delegate_token
  }

  set {
    name  = "managerEndpoint"
    value = var.manager_endpoint
  }

  set {
    name  = "delegateDockerImage"
    value = var.delegate_image
  }

  set {
    name  = "replicas"
    value = var.replicas
  }

  set {
    name  = "upgrader.enabled"
    value = var.upgrader_enabled
  }
}
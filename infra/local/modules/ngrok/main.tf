resource "kubernetes_namespace" "ngrok" {
  count = var.create_namespace ? 1 : 0

  metadata {
    name = var.namespace
  }
}

resource "helm_release" "ngrok_operator" {
  name       = var.release_name
  repository = "https://charts.ngrok.com"
  chart      = "ngrok-operator"
  namespace  = var.create_namespace ? kubernetes_namespace.ngrok[0].metadata[0].name : var.namespace
  version    = var.chart_version

  create_namespace = false
  wait             = true
  timeout          = var.helm_timeout

  set_sensitive {
    name  = "credentials.apiKey"
    value = var.ngrok_api_key
  }

  set_sensitive {
    name  = "credentials.authtoken"
    value = var.ngrok_authtoken
  }

  dynamic "set" {
    for_each = var.helm_values
    content {
      name  = set.key
      value = set.value
    }
  }
}
resource "harness_platform_connector_github" "this" {
  for_each = local.github_connectors

  identifier  = each.value.identifier
  name        = each.value.name
  description = each.value.description
  org_id      = var.organization_id
  project_id  = var.project_id
  url         = coalesce(each.value.url, "https://github.com")

  validation_repo = try(each.value.validation_repo, "k8s")

  connection_type = try(each.value.connection_type, "Repo")

  credentials {
    http {
      username  = each.value.credentials.username
      token_ref = each.value.credentials.token_ref
    }
  }

  dynamic "api_authentication" {
    for_each = lookup(each.value, "api_authentication", null) != null ? [each.value.api_authentication] : []
    content {
      token_ref = api_authentication.value.token_ref
    }
  }
  execute_on_delegate = false
  delegate_selectors  = []

  tags = [
    for k, v in local.merged_tags[each.key] : "${k}:${v}"
  ]
  depends_on = [harness_platform_secret_text.secrets]
}

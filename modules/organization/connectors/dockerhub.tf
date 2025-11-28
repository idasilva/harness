resource "harness_platform_connector_docker" "this" {
  for_each = local.dockerhub_connectors

  identifier  = each.value.identifier
  name        = each.value.name
  description = each.value.description
  org_id      = var.organization_id
  project_id  = var.project_id
  type        = "Other"
  url         = coalesce(each.value.url, "https://index.docker.io/v2/")

  credentials {
    username     = each.value.credentials.username
    password_ref = each.value.credentials.password_ref
  }

  execute_on_delegate = false

  tags = [
    for k, v in local.merged_tags[each.key] : "${k}:${v}"
  ]
   depends_on = [ harness_platform_secret_text.secrets ]
}
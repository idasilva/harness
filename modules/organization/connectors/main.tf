resource "harness_platform_secret_text" "secrets" {
  for_each = nonsensitive(var.secrets)

  identifier                = each.key
  name                      = each.key
  org_id                    = var.organization_id
  project_id                = var.project_id
  value                     = each.value.value
  secret_manager_identifier = each.value.secret_manager_identifier
  value_type                = "Inline"

  lifecycle {
    ignore_changes = [value]
  }
}
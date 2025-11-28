resource "harness_platform_secret_text" "text" {

  identifier = local.fmt_identifier

  name = var.name

  org_id = var.organization_id

  project_id = var.project_id

  description = var.description

  secret_manager_identifier = var.secret_manager

  value_type = var.value_type

  value = var.value

  tags = local.common_tags

}
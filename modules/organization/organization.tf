resource "harness_platform_organization" "ck_org" {
  identifier  = var.organization
  name        = var.organization
  description = "Organization for ${var.organization_unit}"
  
  tags = { for k, v in var.tags : k => join(",", v) }
}
resource "harness_platform_organization" "ck_org" {
  identifier  = local.org_id
  name        = var.organization
  description = "Organization for ${var.organization_unit}"
  
  tags = var.tags
}
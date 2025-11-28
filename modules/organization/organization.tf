
locals {
  organization_id = var.use_default_org ? "default" : harness_platform_organization.ck_org[0].id
}

resource "harness_platform_organization" "ck_org" {
  count = var.use_default_org ? 0 : 1

  identifier  = var.organization
  name        = var.organization
  description = "Organization for ${var.organization_unit}"

  tags = [
    for k, v in var.tags : "${k}:${v}"
  ]
}


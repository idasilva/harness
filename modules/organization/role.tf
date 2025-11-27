resource "harness_platform_role" "project_admin" {
  identifier = "${local.org_id}_project_admin"
  name       = "Project Admin"
  org_id     = harness_platform_organization.ck_org.id
  
  permissions = [
    "core_project_edit",
    "core_project_view",
    "core_project_delete"
  ]
}

resource "harness_platform_role" "project_viewer" {
  identifier = "${local.org_id}_project_viewer"
  name       = "Project Viewer"
  org_id     = harness_platform_organization.ck_org.id
  
  permissions = [
    "core_project_view"
  ]
}
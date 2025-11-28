resource "harness_platform_roles" "project_admin" {
  identifier = "project_admin"
  name       = "Project Admin"
  org_id     = local.organization_id
  
  permissions = [
    "core_project_edit",
    "core_project_view",
    "core_project_delete"
  ]
}

resource "harness_platform_roles" "project_viewer" {
  identifier = "project_viewer"
  name       = "Project Viewer"
  org_id     = local.organization_id
  
  permissions = [
    "core_project_view"
  ]
}
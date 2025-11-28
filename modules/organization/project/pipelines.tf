resource "harness_platform_pipeline" "hello_world" {
  identifier = "hello_world"
  org_id     = var.organization_id
  project_id = var.project
  name       = "${var.project}-pipeline"
  
  yaml = templatefile("${path.module}/templates/hello-world-pipeline.yaml", {
    PROJECT_ID_PLACEHOLDER = var.project
    ORG_ID_PLACEHOLDER     = var.organization_id
  })

}
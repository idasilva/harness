resource "harness_platform_pipeline" "hello_world" {
  identifier = "hello_world"
  org_id     = var.organization_id
  project_id = var.project
  name       = "Hello World Pipeline"
  
  yaml = templatefile("${path.module}/templates/hello-world-pipeline.yaml", {
    PROJECT_ID_PLACEHOLDER = var.project,
    ORG_ID_PLACEHOLDER     = var.organization_id,
    PIPELINE_NAME          = "Hello World Pipeline",
    PIPELINE_IDENTIFIER    = "hello_world"
  })
    depends_on = [ harness_platform_project.ck_project ]
}


resource "harness_platform_pipeline" "ci_pipeline" {
  identifier = "ci_build_push"
  org_id     = var.organization_id
  project_id = var.project
  name       = "CI Pipeline - Build and Push"
  
  yaml = templatefile("${path.module}/templates/ci-pipeline.yaml", {
    PROJECT_ID_PLACEHOLDER = var.project,
    ORG_ID_PLACEHOLDER     = var.organization_id,
    PIPELINE_NAME          = "CI Pipeline - Build and Push"
    PIPELINE_IDENTIFIER    = "ci_build_push"
  })
  depends_on = [ harness_platform_project.ck_project ]
}
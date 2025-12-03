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
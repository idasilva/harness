resource "harness_platform_pipeline" "ci_pipeline" {
  identifier = "ci_build_push"
  org_id     = var.organization_id
  project_id = var.project
  name       = "DEVOPS - CONTINUOUS INTEGRATION GOLANG"
  
  yaml = templatefile("${path.module}/templates/tracked-based-go-github/pipelines/devops-continuous-integration.yaml", {
    PROJECT_ID_PLACEHOLDER = var.project,
    ORG_ID_PLACEHOLDER     = var.organization_id,
    PIPELINE_NAME          = "DEVOPS - CONTINUOUS INTEGRATION GOLANG"
    PIPELINE_IDENTIFIER    = "ci_build_push"
  })
  depends_on = [ harness_platform_project.ck_project ]
}

resource "harness_platform_pipeline" "cd_pipeline" {
  identifier = "cd_deploy"
  org_id     = var.organization_id
  project_id = var.project
  name       = "DEVOPS - CONTINUOUS DELIVERY GOLANG"
  
  yaml = templatefile("${path.module}/templates/tracked-based-go-github/pipelines/devops-continuous-delivery.yaml", {
    PROJECT_ID_PLACEHOLDER = var.project,
    ORG_ID_PLACEHOLDER     = var.organization_id,
    PIPELINE_NAME          = "DEVOPS - CONTINUOUS DELIVERY GOLANG"
    PIPELINE_IDENTIFIER    = "cd_deploy"
  })
  depends_on = [ harness_platform_project.ck_project ]
}

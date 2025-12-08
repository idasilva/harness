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


resource "harness_platform_pipeline" "ci_pipeline_java" {
  identifier = "ci_build_push_java"
  org_id     = var.organization_id
  project_id = var.project
  name       = "DEVOPS - CONTINUOUS INTEGRATION JAVA"
  
  yaml = templatefile("${path.module}/templates/tracked-based-java-github/pipelines/devops-continuous-integration.yaml", {
    PROJECT_ID_PLACEHOLDER = var.project,
    ORG_ID_PLACEHOLDER     = var.organization_id,
    PIPELINE_NAME          = "DEVOPS - CONTINUOUS INTEGRATION JAVA"
    PIPELINE_IDENTIFIER    = "ci_build_push_java"
  })
  depends_on = [ harness_platform_project.ck_project ]
}

resource "harness_platform_pipeline" "cd_pipeline_java" {
  identifier = "cd_deploy_java"
  org_id     = var.organization_id
  project_id = var.project
  name       = "DEVOPS - CONTINUOUS DELIVERY JAVA"
  
  yaml = templatefile("${path.module}/templates/tracked-based-java-github/pipelines/devops-continuous-delivery.yaml", {
    PROJECT_ID_PLACEHOLDER = var.project,
    ORG_ID_PLACEHOLDER     = var.organization_id,
    PIPELINE_NAME          = "DEVOPS - CONTINUOUS DELIVERY JAVA"
    PIPELINE_IDENTIFIER    = "cd_deploy_java"
  })
  depends_on = [ harness_platform_project.ck_project ]
}

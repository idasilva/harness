resource "harness_platform_triggers" "pr_trigger" {
  identifier = "devops_github_pr_trigger"
  org_id     = var.organization_id
  project_id = harness_platform_project.ck_project.id
  name       = "DEVOPS - GITHUB PR TRIGGER GOLANG"
  target_id  = harness_platform_pipeline.ci_pipeline.identifier
  
  yaml = templatefile("${path.module}/templates/tracked-based-go-github/devops-github-pr-trigger.yaml", {
    TRIGGER_NAME        = "DEVOPS - GITHUB PR TRIGGER GOLANG"
    TRIGGER_IDENTIFIER  = "devops_github_pr_trigger"
    PROJECT_ID          = harness_platform_project.ck_project.id
    ORG_ID              = var.organization_id
    PIPELINE_ID         = harness_platform_pipeline.ci_pipeline.identifier
    GITHUB_CONNECTOR    = "github_main"
    TARGET_BRANCH       = "main"
  })
  
  depends_on = [harness_platform_pipeline.ci_pipeline]
}



resource "harness_platform_triggers" "merge_trigger" {
  identifier = "devops_github_merge_trigger"
  org_id     = var.organization_id
  project_id = harness_platform_project.ck_project.id
  name       = "DEVOPS - GITHUB MERGE TRIGGER GOLANG"
  target_id  = harness_platform_pipeline.cd_pipeline.identifier
  
  yaml = templatefile("${path.module}/templates/tracked-based-go-github/devops-github-merge-trigger.yaml", {
    TRIGGER_NAME        = "DEVOPS - GITHUB MERGE TRIGGER GOLANG"
    TRIGGER_IDENTIFIER  = "devops_github_merge_trigger"
    PROJECT_ID          = harness_platform_project.ck_project.id
    ORG_ID              = var.organization_id
    PIPELINE_ID         = harness_platform_pipeline.cd_pipeline.identifier
    GITHUB_CONNECTOR    = "github_main"
    TARGET_BRANCH       = "main"
  })
  
  depends_on = [harness_platform_pipeline.cd_pipeline]
}
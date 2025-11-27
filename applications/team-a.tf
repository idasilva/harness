module "anti_fraud" {
  source = "./modules/organization"
  
  organization = "team-a-org"
  organization_unit = "team-a-dept"
  projects     = ["team-a-pipeline1", "team-a-pipeline2"]
  platform_api_key  = var.platform_api_key
  account_id        = var.account_id
}
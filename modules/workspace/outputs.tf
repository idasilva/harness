output "name" {
  value = var.name
}

output "environment" {
  value = local.environment
}

output "default_tags" {
  value = {
    "infra/provisioned-by" = "terraform"
  }
}



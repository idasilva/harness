terraform {
  required_providers {
    null = {
      source = "hashicorp/null"
      version = "3.2.4"
    }
    external = {
      source  = "hashicorp/external"
      version = "~> 2.0"
    }
  }
}
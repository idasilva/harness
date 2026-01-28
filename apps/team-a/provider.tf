terraform {
  required_providers {
    harness = {
      source = "harness/harness"
      version = "0.39.3"
    }
  }
}

provider "harness" {
  endpoint         = "https://app.harness.io/gateway"
  account_id       = "XPTO"
  platform_api_key = "XPTO"
}
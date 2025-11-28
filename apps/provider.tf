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
  account_id       = "9leDao-yRqu7DN66....."
  platform_api_key = "pat.9leDao-yRqu7DN66CVDAeg.692VWgKrUT....."
}
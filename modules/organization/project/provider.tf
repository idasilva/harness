terraform {
  required_providers {
    harness = {
      source = "harness/harness"
      version = "0.39.3"
    }
     kubectl = {
      source  = "gavinbunney/kubectl"
      version = "~> 1.14"
    }
  }
}
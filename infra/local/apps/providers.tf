terraform {
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "3.2.4"
    }
    external = {
      source  = "hashicorp/external"
      version = "~> 2.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.23"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.11"
    }
  }
}

provider "kubernetes" {
  host                   = module.k8s.cluster_endpoint
  cluster_ca_certificate = base64decode(module.k8s.cluster_ca_data)
  token                  = module.k8s.cluster_token
}

provider "helm" {
  kubernetes {
    host                   = module.k8s.cluster_endpoint
    cluster_ca_certificate = base64decode(module.k8s.cluster_ca_data)
    token                  = module.k8s.cluster_token
  }
}

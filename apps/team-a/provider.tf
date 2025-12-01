terraform {
  required_providers {
    harness = {
      source = "harness/harness"
      version = "0.39.3"
    }
  }
}

# provider "kubernetes" {
#   host                   = data.aws_eks_cluster.cluster.endpoint
#   cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
#   exec {
#     api_version = "client.authentication.k8s.io/v1beta1"
#     args        = ["eks", "get-token", "--cluster-name", data.aws_eks_cluster.cluster.id]
#     command     = "aws"
#   }
# }

provider "harness" {
  endpoint         = "https://app.harness.io/gateway"
  account_id       = "XPTO"
  platform_api_key = "XPTO"
}
module "kubernetes" {
  source = "../modules/kubernetes"

  cluster_name       = var.cluster_name
  nodes              = var.nodes
  kubernetes_version = var.kubernetes_version
}
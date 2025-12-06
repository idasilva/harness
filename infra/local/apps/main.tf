module "k8s" {
  source = "../modules/k8s"

  cluster_name       = var.cluster_name
  nodes              = var.nodes
  kubernetes_version = var.kubernetes_version
}


module "argocd" {
  source = "../modules/argocd"
  argocd_namespace = "argocd"

  depends_on = [ module.k8s ]
}
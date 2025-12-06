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

module "ngrok" {
  source = "../modules/ngrok"

  ngrok_api_key   = var.ngrok_api_key
  ngrok_authtoken = var.ngrok_authtoken
  
  namespace    = "ngrok-ingress-controller"
  release_name = "ngrok-operator"

  depends_on = [ module.k8s ]
}
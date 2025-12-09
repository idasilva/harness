resource "helm_release" "jenkins" {
  name             = "myjenkins"
  repository       = "https://charts.jenkins.io"
  chart            = "jenkins"
  namespace        = "jenkins"
  create_namespace = true
  
  set {
    name  = "controller.serviceType"
    value = "ClusterIP"
  }
  
  set {
    name  = "controller.admin.password"
    value = "admin123"
  }
}
variable "cluster_name" {
  description = "Name of the Kind cluster"
  type        = string
}

variable "nodes" {
  description = "Number of worker nodes (control-plane + workers)"
  type        = number
  default     = 2
}

variable "kubernetes_version" {
  description = "Kubernetes version (kind node image)"
  type        = string
  default     = "v1.32.0"
}
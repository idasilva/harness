variable "cluster_name" {
  description = "Name of the Kind cluster"
  type        = string
  default     = "harness-local"
}

variable "nodes" {
  description = "Number of nodes (1 control-plane + N workers)"
  type        = number
  default     = 2
}

variable "kubernetes_version" {
  description = "Kubernetes version"
  type        = string
  default     = "v1.27.3"
}
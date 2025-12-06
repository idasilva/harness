variable "cluster_name" {
  description = "Name of the Kind cluster"
  type        = string
  default     = "harness-local"
}

variable "nodes" {
  description = "Number of nodes (1 control-plane + N workers)"
  type        = number
  default     = 5
}

variable "kubernetes_version" {
  description = "Kubernetes version"
  type        = string
  default     = "v1.32.0"
}

variable "ngrok_api_key" {
  description = "ngrok API Key"
  type        = string
  default = "XPTO"
  sensitive   = true
}

variable "ngrok_authtoken" {
  description = "ngrok Auth Token"
  type        = string
  default = "XPTO"
  sensitive   = true
}

variable "default_namespaces" {
  description = "Default namespaces to create"
  type        = list(string)
  default     = ["development", "staging", "production"]
}
variable "ngrok_api_key" {
  description = "ngrok API Key"
  type        = string
  sensitive   = true
}

variable "ngrok_authtoken" {
  description = "ngrok Auth Token"
  type        = string
  sensitive   = true
}

variable "namespace" {
  description = "Kubernetes namespace for ngrok operator"
  type        = string
  default     = "ngrok-ingress-controller"
}

variable "create_namespace" {
  description = "Create namespace if it doesn't exist"
  type        = bool
  default     = true
}

variable "release_name" {
  description = "Helm release name"
  type        = string
  default     = "ngrok-operator"
}

variable "chart_version" {
  description = "ngrok operator chart version"
  type        = string
  default     = null
}

variable "helm_timeout" {
  description = "Helm operation timeout in seconds"
  type        = number
  default     = 300
}

variable "helm_values" {
  description = "Additional Helm values"
  type        = map(string)
  default     = {}
}
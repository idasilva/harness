variable "harness_endpoint" {
  description = "Harness API endpoint"
  type        = string
}

variable "account_id" {
  description = "Harness account ID"
  type        = string
  sensitive   = true
}

variable "platform_api_key" {
  description = "Harness platform API key"
  type        = string
  sensitive   = true
}

variable "organization" {
  description = "Organization name"
  type        = string
}

variable "organization_unit" {
  description = "Organization unit"
  type        = string
}

variable "projects1" {
  description = "Projects map"
  type        = map(any)
}

variable "kubernetes_clusters" {
  description = "Kubernetes clusters"
  type        = map(any)
  default     = {}
}
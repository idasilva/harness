variable "delegate_name" {
  type    = string
  default = "helm-delegate"
}

variable "namespace" {
  type    = string
  default = "harness-delegate-ng"
}

variable "account_id" {
  type = string
}

variable "delegate_token" {
  type      = string
  sensitive = true
}

variable "manager_endpoint" {
  type    = string
  default = "https://app.harness.io"
}

variable "delegate_image" {
  type    = string
  default = "us-docker.pkg.dev/gar-prod-setup/harness-public/harness/delegate:25.11.87301"
}

variable "replicas" {
  type    = number
  default = 1
}

variable "upgrader_enabled" {
  type    = bool
  default = true
}
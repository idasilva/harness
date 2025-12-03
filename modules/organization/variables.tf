variable "account_id" {
  description = "Harness account ID"
  type        = string
  sensitive   = true
}

variable "organization" {
  description = "Organization name"
  type        = string
  default = "default"
}

variable "organization_unit" {
  description = "Organization unit"
  type        = string
}

variable "projects" {
  description = "Projects map"
  type        = list(string)
}

variable "tags" {
  description = "A mapping of tags to assign to the bucket."
  type        = map(string)
}

variable "use_default_org" {
  description = "Use default organization (for free plan)"
  type        = bool
  default     = false
}

variable "secrets" {
  description = "Secrets to create for connectors"
  type = map(object({
    value                     = string
    secret_manager_identifier = optional(string, "harnessSecretManager")
  }))
  default   = {}
  sensitive = true
}

variable "connectors" {
  description = "Map of connectors to create"
  type = map(object({
    type        = string
    enabled     = bool
    name        = string
    identifier  = string
    description = optional(string)
    url         = optional(string)
    credentials = optional(object({
      username       = optional(string)
      password_ref   = optional(string)
      token_ref      = optional(string)
      api_key_ref    = optional(string)
      access_key     = optional(string)
      secret_key_ref = optional(string)
    }))
    api_authentication = optional(object({
    token_ref = string
    }))
    validation_repo    = optional(string)
    connection_type    = optional(string)
    delegate_selectors = optional(list(string))
    tags              = optional(map(string))
  }))
  default = {}
}

variable "create_connectors_for_projects" {
  description = "List of projects to create connectors for (empty = all projects)"
  type        = set(string)
  default     = []
}

variable "enable_gitops" {
  description = "Enable GitOps infrastructure"
  type        = bool
  default     = false
}

variable "gitops_config" {
  description = "GitOps infrastructure configuration"
  type = object({
    agent_namespace   = string
    high_availability = bool
    cluster_server    = string
    cluster_name      = string
  })
  default = {
    agent_namespace   = "harness-gitops"
    high_availability = false
    cluster_server    = "https://kubernetes.default.svc"
    cluster_name      = "in-cluster"
  }
}

variable "github_repo" {
  description = "GitHub repository"
  type        = string
  default     = ""
}

variable "dockerhub_repo" {
  description = "DockerHub repository"
  type        = string
  default     = ""
}
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
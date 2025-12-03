variable "organization_id" {
  description = "Organization ID"
  type        = string
}

variable "project_id" {
  description = "Project ID"
  type        = string
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
      username     = optional(string)
      password_ref = optional(string)
      token_ref    = optional(string)
      api_key_ref  = optional(string)
      access_key   = optional(string)
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

variable "default_tags" {
  description = "Default tags to apply to all connectors"
  type        = map(string)
  default     = {}
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
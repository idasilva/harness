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

variable "projects" {
  description = "Projects map"
  type        = list(string)
}

variable "tags" {
  description = "A mapping of tags to assign to the bucket."
  type        = map(string)
}
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
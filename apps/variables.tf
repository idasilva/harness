variable "organization" {
  description = "The AWS region to work in"
  type        = string
  default     = "team-a-org"
}

variable "organization_unit" {
  description = "The AWS region to work in"
  type        = string
  default     = "team-a-dept"
}

variable "account_id" {
  description = "The AWS region to work in"
  type        = string
  default     = "9leDao-yRqu7DN66CVDAeg"
}

variable "platform_api_key" {
  description = "The AWS region to work in"
  type        = string
  default     = "pat.9leDao-yRqu7DN66CVDAeg.6926336aa92d3d7021d6b378.ALIxclA4ZN1wIjdo2BEl"
}

variable "projects" {
  description = "List of projects"
  default     = ["project1", "project2", "project3"]
  type        = list(string)
}

variable "organization" {
  description = "The AWS region to work in"
  type        = string
  default     = "iscorg"
}

variable "organization_unit" {
  description = "The AWS region to work in"
  type        = string
  default     = "teama"
}

variable "account_id" {
  description = "The AWS region to work in"
  type        = string
  default     = "9leDao-yRqu7DN66CVDAeg"
}

variable "projects" {
  description = "List of projects"
  default     = ["project1", "project2", "project3"]
  type        = list(string)
}

variable "project" {
  description = "Project name"
  type        = string
}

variable "organization_id" {
  description = "Harness organization ID"
  type        = string
}

variable "color" {
  description = "Project color in Harness UI"
  type        = string
  default     = "#0063F7"
}

variable "description" {
  description = "Project description"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Tags to apply to the project"
  type        = map(string)
}
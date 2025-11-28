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

variable "account_id" {
  description = "Harness Account ID"
  type        = string
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
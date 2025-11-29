variable "organization" {
  description = "The AWS region to work in"
  type        = string
  default     = "default"
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
  default     = ["project1"]
  type        = list(string)
}

variable "use_default_org" {
  description = "Use default organization (for free plan)"
  type        = bool
  default     = true
}

variable "create_connectors_for_projects" {
  description = "List of projects to create connectors for"
  type        = set(string)
  default     = ["project1"]
}

variable "github_username" {
  description = "GitHub username"
  type        = string
  default     = "team-a-bot"
}

variable "github_repo" {
  description = "GitHub repository"
  type        = string
  default     = "idasilva/k8s"
}

variable "github_token" {
  description = "GitHub personal access token"
  type        = string
  sensitive   = true
  default     = ""
}

variable "dockerhub_username" {
  description = "DockerHub username"
  type        = string
  default     = "teama"
}

variable "dockerhub_password" {
  description = "DockerHub password"
  type        = string
  sensitive   = true
  default     = ""
}

variable "secrets" {
  description = "Secrets to create for connectors"
  type = map(object({
    value                     = string
    secret_manager_identifier = optional(string, "harnessSecretManager")
  }))
  sensitive = true
  default = {
    github_token = {
      value                     = "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"
      secret_manager_identifier = "harnessSecretManager"
    }
    dchub_token = {
      value                     = "dckr_pat_dT8QwNuCkK2k2jseIHO4QA2P1eY"
      secret_manager_identifier = "harnessSecretManager"
    }
  }
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
  default = {
    github_main = {
      type        = "github"
      enabled     = true
      name        = "GitHub Main"
      identifier  = "github_main"
      description = "Main GitHub connector"
      url         = "https://github.com/idasilva/luffy-services"
      connection_type = "Repo"
      credentials = {
        username  = "idasilva"
        token_ref = "github_token"
      }
    }

    dockerhub_main = {
      type        = "dockerhub"
      enabled     = true
      name        = "Docker Hub Main"
      identifier  = "dockerhub_main"
      description = "Main Docker Hub connector"
      credentials = {
        username     = "idasilva6" 
        password_ref = "dchub_token"
      }
    }
  }
}

variable "enable_gitops" {
  description = "Enable GitOps infrastructure (agent, cluster, repository)"
  type        = bool
  default     = true
}

variable "gitops_config" {
  description = "GitOps infrastructure configuration"
  type = object({
    agent_namespace   = optional(string, "harness-gitops")
    high_availability = optional(bool, false)
    cluster_server    = optional(string, "https://kubernetes.default.svc")
    cluster_name      = optional(string, "in-cluster")
  })
  default = {
    agent_namespace   = "harness-gitops"
    high_availability = false
    cluster_server    = "https://kubernetes.default.svc"
    cluster_name      = "in-cluster"
  }
}
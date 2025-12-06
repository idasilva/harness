locals {
  environments = {
    dev = {
      name        = "Development"
      type        = "PreProduction"
      branch      = "develop"
      namespace   = "development"
    }
    staging = {
      name        = "Staging"
      type        = "PreProduction"
      branch      = "staging"
      namespace   = "staging"
    }
    production = {
      name        = "Production"
      type        = "Production"
      branch      = "main"
      namespace   = "production"
    }
  }

  services = {
    luffy = {
      name        = "luffy-apps"
      repo_name   = "harness"
      folder_path = "/services/luffy/deployment/luffy-apps"
      type        = "go"
    }
    usopp = {
      name        = "usopp-service"
      repo_name   = "harness"
      folder_path = "/services/usopp/deployment/usopp-apps"
      type        = "java"
    }
    nami = {
      name        = "nami-service"
      repo_name   = "harness"
      folder_path = "/services/nami/deployment/nami-apps"
      type        = "python"
    }
  }

  # Create service-environment pairs
  service_env_pairs = flatten([
    for env_key, env in local.environments : [
      for svc_key, svc in local.services : {
        key          = "${svc_key}_${env_key}"
        svc_key      = svc_key
        env_key      = env_key
        svc_name     = svc.name
        env_name     = env.name
        branch       = env.branch
        namespace    = env.namespace
        repo_name    = svc.repo_name
        folder_path  = svc.folder_path
        svc_type     = svc.type
        values_file  = "${svc.folder_path}/${env_key}-values.yaml"
      }
    ]
  ])

  service_env_map = {
    for pair in local.service_env_pairs :
    pair.key => pair
  }
}
locals {
  environments = {
    dev = {
      name = "Development"
      type = "PreProduction"
    }
    staging = {
      name = "Staging"
      type = "PreProduction"
    }
    production = {
      name = "Production"
      type = "Production"
    }
  }
}
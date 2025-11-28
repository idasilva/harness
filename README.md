# harness

Structure
```
├── applications/          # Team/Application-specific project definitions
│   ├── team-a.tf          # Team A project configuration
│   ├── team-b.tf          # Team B project configuration
│   └── team-c.tf          # Team C project configuration
│
├── modules/               # Reusable Terraform modules
│   └── organization/      # Organization module
│       ├── project/       # Project sub-module
│       │   ├── main.tf
│       │   ├── output.tf
│       │   └── variables.tf
│       ├── services/      # Services sub-module (future)
│       ├── organization.tf
│       ├── project.tf
│       ├── provider.tf
│       ├── role.tf
│       └── variables.tf
│
├── LICENSE
└── README.md

```

Usage

```
module "team_d_project" {
  source = "../modules/organization/project"

  project         = "Team-D"
  organization_id = var.organization_id
  color           = "#9C27B0"
  description     = "Team D project and services"
  
  tags = {
    team       = "team-d"
    managed_by = "terraform"
  }
}
```

Ref

- https://github.com/harness-community/solutions-architecture/blob/main/terraform-harness-modules/structure.tf
- https://github.com/harness-community/terraform-harness-structure
- https://www.youtube.com/watch?v=OTeckDYXxS0
- https://registry.terraform.io/providers/harness/harness/latest/docs
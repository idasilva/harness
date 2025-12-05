# harness

This is a basic project to build Harness projects

---

📁  Structure
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

🚀  Usage

```
module "team_d_project" {
  source = "../modules/organization"

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

🏗️ Harness Hierarchy

Access is managed at the following scopes:

- **Account**: Can create multiple organizations
  - **Organization**: Groups projects with shared goals (business unit level)
    - Resources at this level are available to all projects within the org
  - **Project**: Team-managed, groups Harness modules

⚠️ Warning
This will probaly happen to you if using Free license.
```
 Invalid request: You've reached the limit of 1 entities under your FREE license. Please contact Harness Support for assistance.
```
**Solution:** Set use_default_org = true in your module configuration to use the default organization and bypass this limitation:

🐳 Locally
```
docker run -d \
  -p 3000:3000 \
  -p 3022:3022 \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v /tmp/harness:/data \
  --name harness \
  --restart always \
  harness/harness
```

📦🚢 Pipeline strategy

```
PR Opened → PR Pipeline (CI + Security)
├── Clone code
│   └── Get code from PR branch to start analysis
├── Secret Detection (Gitleaks)
│   └── Find accidentally committed secrets (API keys, passwords, tokens)
├── Linting (language-specific)
│   └── Enforce code quality (syntax errors, bad practices, style violations)
├── SAST scan (SonarQube/Bandit)
│   └── Find security vulnerabilities in source code (SQL injection, insecure functions)
├── SCA - Dependency Check (OWASP Dependency-Check)
│   └── Find vulnerabilities in libraries you use (outdated packages, known CVEs)
├── Run tests
│   └── Verify code works correctly (functionality, regressions, edge cases)
├── Build image (tag: commit SHA)
│   └── Package app into Docker container with traceable version
├── Container scan (Trivy)
│   └── Find vulnerabilities in Docker image (vulnerable base images, misconfigurations)
└── Comment aggregated results on PR
    └── Post all scan results as single PR comment for developer feedback

PR Merged → Deploy Pipeline (CD)
├── Pull latest image (pre-scanned from PR)
│   └── Get the Docker image that already passed security checks
├── Deploy to dev
│   └── Run app in development environment
├── DAST scan (OWASP ZAP - on dev environment)
│   └── Test running application for runtime vulnerabilities (XSS, CSRF, security headers)
├── Approval
│   └── Human gate - review DAST results before promoting
├── Deploy to staging
│   └── Test in production-like environment
├── Integration tests
│   └── Test how components work together (database, APIs, services)
├── Approval
│   └── Final human check before production
└── Deploy to production
    └── Ship it!
```

📚 References

- https://github.com/harness/harness
- https://github.com/harness-community/gitops-terraform-onboarding/blob/main/variables.tf
- https://github.com/harness-community/solutions-architecture/blob/main/terraform-harness-modules/structure.tf
- https://blog.techiescamp.com/using-ngrok-with-kubernetes/
- https://github.com/harness-community/terraform-harness-structure
- https://www.youtube.com/watch?v=OTeckDYXxS0
- https://github.com/harness-community/harnesscd-example-apps/blob/master/sync-waves/manifests.yaml
- https://registry.terraform.io/providers/harness/harness/latest/docs
- https://developer.harness.io/docs/continuous-delivery/gitops/get-started/harness-cd-git-ops-quickstart
- https://www.youtube.com/watch?v=gpoXT9eoSWg
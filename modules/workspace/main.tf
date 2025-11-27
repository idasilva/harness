locals {
  workspace_tks = split("-", var.name)
  environment   = element(local.workspace_tks, length(local.workspace_tks) - 1)
}

locals {
  github_connectors = {
    for k, v in var.connectors : k => v
    if v.type == "github" && v.enabled
  }

  dockerhub_connectors = {
    for k, v in var.connectors : k => v
    if v.type == "dockerhub" && v.enabled
  }

  aws_connectors = {
    for k, v in var.connectors : k => v
    if v.type == "aws" && v.enabled
  }

  gcp_connectors = {
    for k, v in var.connectors : k => v
    if v.type == "gcp" && v.enabled
  }

  kubernetes_connectors = {
    for k, v in var.connectors : k => v
    if v.type == "kubernetes" && v.enabled
  }

  merged_tags = {
    for k, v in var.connectors : k => merge(var.default_tags, v.tags != null ? v.tags : {})
  }
}
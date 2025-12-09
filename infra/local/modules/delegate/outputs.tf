output "namespace" {
  value = helm_release.harness_delegate.namespace
}

output "delegate_name" {
  value = helm_release.harness_delegate.name
}
data "external" "cluster_info" {
  program = ["bash", "-c", <<-EOT
    set -e
    CONTEXT="kind-${var.cluster_name}"
    
    # Get cluster endpoint and CA data
    SERVER=$(kubectl config view --minify --context $CONTEXT -o jsonpath='{.clusters[0].cluster.server}')
    CA_DATA=$(kubectl config view --minify --context $CONTEXT --raw -o jsonpath='{.clusters[0].cluster.certificate-authority-data}')
    
    # Create service account for Terraform (suppress output)
    kubectl --context $CONTEXT create namespace terraform-system --dry-run=client -o yaml | kubectl --context $CONTEXT apply -f - >&2
    kubectl --context $CONTEXT create serviceaccount terraform-admin -n terraform-system --dry-run=client -o yaml | kubectl --context $CONTEXT apply -f - >&2
    
    # Give cluster-admin permissions
    kubectl --context $CONTEXT create clusterrolebinding terraform-admin-binding \
      --clusterrole=cluster-admin \
      --serviceaccount=terraform-system:terraform-admin \
      --dry-run=client -o yaml | kubectl --context $CONTEXT apply -f - >&2
    
    # Create long-lived token
    TOKEN=$(kubectl --context $CONTEXT create token terraform-admin -n terraform-system --duration=87600h)
    
    # Output ONLY JSON to stdout
    jq -n \
      --arg server "$SERVER" \
      --arg ca "$CA_DATA" \
      --arg token "$TOKEN" \
      '{server: $server, ca_data: $ca, token: $token}'
  EOT
  ]

  depends_on = [null_resource.kind_cluster]
}
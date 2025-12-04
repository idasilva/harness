data "external" "cluster_info" {
  program = ["bash", "-c", <<-EOT
    set -e
    CONTEXT="kind-${var.cluster_name}"
    
    # Get cluster endpoint and CA data
    SERVER=$(kubectl config view --context $CONTEXT -o jsonpath='{.clusters[0].cluster.server}')
    CA_DATA=$(kubectl config view --context $CONTEXT --raw -o jsonpath='{.clusters[0].cluster.certificate-authority-data}')
    
    # Create namespace and service account for Harness (suppress output)
    kubectl --context $CONTEXT create namespace harness-gitops --dry-run=client -o yaml | kubectl --context $CONTEXT apply -f - >&2
    kubectl --context $CONTEXT create serviceaccount harness-gitops-sa -n harness-gitops --dry-run=client -o yaml | kubectl --context $CONTEXT apply -f - >&2
    
    # Create cluster role binding (suppress output)
    kubectl --context $CONTEXT create clusterrolebinding harness-gitops-sa-binding \
      --clusterrole=cluster-admin \
      --serviceaccount=harness-gitops:harness-gitops-sa \
      --dry-run=client -o yaml | kubectl --context $CONTEXT apply -f - >&2

     # Install Argo Rollouts
    echo "Installing Argo Rollouts..." >&2
    kubectl --context $CONTEXT create namespace argo-rollouts --dry-run=client -o yaml | kubectl --context $CONTEXT apply -f - >&2
    kubectl --context $CONTEXT apply -n argo-rollouts -f https://github.com/argoproj/argo-rollouts/releases/latest/download/install.yaml >&2
    
    # Wait for Argo Rollouts to be ready
    echo "Waiting for Argo Rollouts to be ready..." >&2
    kubectl --context $CONTEXT wait --for=condition=available --timeout=300s deployment/argo-rollouts -n argo-rollouts >&2
    echo "Argo Rollouts installed successfully!" >&2
    
    # Create long-lived token
    TOKEN=$(kubectl --context $CONTEXT create token harness-gitops-sa -n harness-gitops --duration=87600h)
    
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
resource "null_resource" "kind_cluster" {
  triggers = {
    cluster_name = var.cluster_name
    nodes        = var.nodes
  }

  provisioner "local-exec" {
    command = <<-EOT
      cat <<EOF | kind create cluster --name ${var.cluster_name} --config=-
      kind: Cluster
      apiVersion: kind.x-k8s.io/v1alpha4
      name: ${var.cluster_name}
      nodes:
      - role: control-plane
        extraPortMappings:
        - containerPort: 80
          hostPort: 80
        - containerPort: 443
          hostPort: 443
${join("\n", [for i in range(var.nodes - 1) : "      - role: worker"])}
      EOF
      
      echo "Waiting for cluster to be ready..."
      kubectl wait --for=condition=Ready nodes --all --timeout=300s --context kind-${var.cluster_name}
      echo "Cluster ${var.cluster_name} is ready!"
    EOT
  }

  provisioner "local-exec" {
    when    = destroy
    command = "kind delete cluster --name ${self.triggers.cluster_name} || true"
  }
}

data "external" "cluster_info" {
  program = ["bash", "-c", <<-EOT
    set -e
    CONTEXT="kind-${var.cluster_name}"
    
    # Get cluster endpoint and CA data
    SERVER=$(kubectl config view --context $CONTEXT -o jsonpath='{.clusters[0].cluster.server}')
    CA_DATA=$(kubectl config view --context $CONTEXT --raw -o jsonpath='{.clusters[0].cluster.certificate-authority-data}')
    
    # Create namespace and service account for Harness
    kubectl --context $CONTEXT create namespace harness-gitops --dry-run=client -o yaml | kubectl --context $CONTEXT apply -f -
    kubectl --context $CONTEXT create serviceaccount harness-gitops-sa -n harness-gitops --dry-run=client -o yaml | kubectl --context $CONTEXT apply -f -
    
    # Create cluster role binding
    kubectl --context $CONTEXT create clusterrolebinding harness-gitops-sa-binding \
      --clusterrole=cluster-admin \
      --serviceaccount=harness-gitops:harness-gitops-sa \
      --dry-run=client -o yaml | kubectl --context $CONTEXT apply -f -
    
    # Create long-lived token
    TOKEN=$(kubectl --context $CONTEXT create token harness-gitops-sa -n harness-gitops --duration=87600h)
    
    # Output as JSON
    jq -n \
      --arg server "$SERVER" \
      --arg ca "$CA_DATA" \
      --arg token "$TOKEN" \
      '{server: $server, ca_data: $ca, token: $token}'
  EOT
  ]

  depends_on = [null_resource.kind_cluster]
}
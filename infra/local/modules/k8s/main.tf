resource "null_resource" "kind_cluster" {
  triggers = {
    cluster_name = var.cluster_name
    nodes        = var.nodes
  }

  provisioner "local-exec" {
    command = <<-EOT
      cat <<'KINDCONFIG' | kind create cluster --name ${var.cluster_name} --config=-
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
%{~ for i in range(var.nodes - 1)}
- role: worker
%{~ endfor}
KINDCONFIG
      
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

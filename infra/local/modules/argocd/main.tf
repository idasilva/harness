resource "helm_release" "argocd" {
  name             = "argocd"
  chart            = "argo-cd"
  repository       = "https://argoproj.github.io/argo-helm"
  version          = "7.8.11"
  namespace        = var.argocd_namespace
  create_namespace = true
  timeout          = "1200"
  values = [<<EOF

  configs:
    params:
      create: true
      server.insecure: "true"
  server:
    extensions:
      enabled: true
      extensionList:
      - name: rollout-extension
        env:
          - name: EXTENSION_URL
            value: https://github.com/argoproj-labs/rollout-extension/releases/download/v0.3.4/extension.tar
EOF
  ]
}


# Argo Rollouts Helm Release
resource "helm_release" "argo_rollouts" {
  name             = "argo-rollouts"
  chart            = "argo-rollouts"
  repository       = "https://argoproj.github.io/argo-helm"
  version          = "2.38.1"
  namespace        = var.argocd_namespace
  create_namespace = true
  timeout          = 600

  values = [<<EOF
controller:
  metrics:
    enabled: true
    serviceMonitor:
      enabled: false

notifications:
  enabled: false
EOF
  ]

  depends_on = [helm_release.argocd]
}
provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

resource "helm_release" "alertmanager" {
  name       = "alertmanager"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "alertmanager"
  namespace  = kubernetes_namespace.monitoring.metadata[0].name
  values     = [file("${path.module}/values.yaml")]
}
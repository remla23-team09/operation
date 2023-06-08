resource "kubernetes_namespace" "k8s_namespace" {
  metadata {
    name = var.namespace_name
    annotations = var.annotations
    labels = var.labels
  }
}

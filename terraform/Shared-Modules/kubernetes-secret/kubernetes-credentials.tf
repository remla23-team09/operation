resource "kubernetes_secret" "k8s_credentials" {
  metadata = var.metadata
  data = var.data
}
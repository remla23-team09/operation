output "pvc_name" {
  value = kubernetes_persistent_volume_claim.persistent_volume_claim.metadata[0].name
}
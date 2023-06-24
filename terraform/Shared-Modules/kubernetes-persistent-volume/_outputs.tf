output "pv_name" {
  value = kubernetes_persistent_volume.persistent_volume.metadata[0].name
}
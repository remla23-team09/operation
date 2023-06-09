resource "kubernetes_persistent_volume_claim" "persistent_volume_claim" {
  metadata {
    name = var.metadata.name
  }

  spec {
    access_modes = var.spec.access_modes
    resources {
      requests = {
        storage = var.spec.storage
      }
    }
    storage_class_name = var.spec.storage_class_name
  }
}
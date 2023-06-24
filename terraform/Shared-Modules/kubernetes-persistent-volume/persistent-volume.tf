resource "kubernetes_persistent_volume" "persistent_volume" {
  metadata {
    name = var.metadata.name
  }
  
  spec {
    capacity = {  
      storage = var.spec.storage
    }
    access_modes = var.spec.access_modes
    persistent_volume_source {
      vsphere_volume {
        volume_path = var.spec.vsphere_volume_path
      }
    }
  }
}
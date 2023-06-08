data "local_file" "dashboard" {
  filename  = var.file_path
}

resource "kubernetes_config_map" "configmap" {
  metadata {
    name      = var.name
    namespace = var.namespace
    labels    = var.labels
  }

  data = {
    "${var.name}.json" = data.local_file.dashboard.content
  }
}

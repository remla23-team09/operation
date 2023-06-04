resource "google_container_cluster" "gke_cluster" {
  name     = "${var.name}-gke"
  location = var.location

  remove_default_node_pool = true
  initial_node_count       = 1
}
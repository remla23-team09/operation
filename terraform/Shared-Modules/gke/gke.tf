resource "google_container_cluster" "gke_cluster" {
  name     = "${var.project}-${var.team}-gke"
  location = var.location

  remove_default_node_pool = true
  initial_node_count       = 1
}
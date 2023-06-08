resource "google_container_node_pool" "default_node_pool" {
  name       = var.gke_node_pool_config.name
  location   = var.location

  cluster    = google_container_cluster.gke_cluster.name
  node_locations = var.gke_node_pool_config.node_locations
  
  autoscaling {
    min_node_count = 1
    max_node_count = 3
  }

  node_config {
    preemptible  = true
    machine_type = "e2-standard-2"

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = google_service_account.gke_service_account.email
    oauth_scopes    = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}
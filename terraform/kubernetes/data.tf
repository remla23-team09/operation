data "google_client_config" "current" {}

data "google_container_cluster" "remla_team09_cluster" {
  name = "remla23-team09-gke"
  location = "europe-west4"
}
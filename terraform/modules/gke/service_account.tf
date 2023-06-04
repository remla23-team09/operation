resource "google_service_account" "gke_service_account" {
  account_id   = "${var.name}-gke-sa"
  display_name = "${var.name}-gke-sa"
}
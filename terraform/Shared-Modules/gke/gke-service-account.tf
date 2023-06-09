resource "google_service_account" "gke_service_account" {
  account_id   = "${var.project}-${var.team}-gke-sa"
  display_name = "${var.project}-${var.team}-gke-sa"
}
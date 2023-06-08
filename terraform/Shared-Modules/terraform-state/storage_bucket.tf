resource "google_storage_bucket" "terraform_state_bucket" {
  name          = "${var.project}-${var.team}-terraform-state-bucket"
  location      = var.location

}
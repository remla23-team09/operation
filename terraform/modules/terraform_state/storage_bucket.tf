resource "google_storage_bucket" "terraform_state_bucket" {
  name          = "${var.name}-terraform-state-bucket"
  location      = var.location

}
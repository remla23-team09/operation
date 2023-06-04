terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.67.0"
    }
  }
  backend "gcs" {
    bucket = "remla23-team09-terraform-state-bucket"
    prefix = "terraform"
  }
}

provider "google" {
  project = "kgarremla23"
  region = "europe-west4"
}
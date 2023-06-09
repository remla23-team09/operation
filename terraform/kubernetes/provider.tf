terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.67.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.21.1"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.10.1"
    }
  }
  backend "gcs" {
    bucket = "remla23-team09-terraform-state-bucket"
    prefix = "terraform-kubernetes"
  }
}

provider "google" {
  project = "kgarremla23"
  region  = "europe-west4"
}

# provider "kubernetes" {
#   config_path = var.kubeconfig
# }

provider "helm" {
  kubernetes {
    host                   = "https://${data.google_container_cluster.remla_team09_cluster.endpoint}"
    token                  = data.google_client_config.current.access_token
    cluster_ca_certificate = base64decode(data.google_container_cluster.remla_team09_cluster.master_auth[0].cluster_ca_certificate)
  }
}

provider "kubernetes" {
  host                   = "https://${data.google_container_cluster.remla_team09_cluster.endpoint}"
  token                  = data.google_client_config.current.access_token
  cluster_ca_certificate = base64decode(data.google_container_cluster.remla_team09_cluster.master_auth[0].cluster_ca_certificate)
}

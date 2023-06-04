variable "location" {
  type        = string
  default = "europe-west4"
}

variable "gke_config" {
  default = {
    # default_max_pods_per_node = 80
  }
}

variable "vnet_config" {
  default = {
    routing_mode = "REGIONAL"
    auto_create_subnetworks = false
  }
}
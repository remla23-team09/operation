variable "project" {
  type        = string
  default = "remla23"
}

variable "team" {
  type        = string
  default = "team09"
}

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
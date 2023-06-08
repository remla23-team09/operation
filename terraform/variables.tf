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
    # location = "europe-west4-a"
  }
}

variable "gke_node_pool_config" {
  default = {
    name     = "default"
    location = "europe-west4-a"
  }
}

variable "vnet_config" {
  default = {
    routing_mode = "REGIONAL"
    auto_create_subnetworks = false
  }
}
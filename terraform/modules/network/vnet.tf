resource "google_compute_network" "vnet" {
  name = "${var.name}-vnet"

  routing_mode            = var.vnet_config.routing_mode
  auto_create_subnetworks = var.vnet_config.auto_create_subnetworks
}

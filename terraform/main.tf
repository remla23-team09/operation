# module "services" {
#   source = "./Shared-Modules/services"
# }

# module "network" {
#   source = "./Shared-Modules/network"
#   name = "remla23-team09"
#   vnet_config = var.vnet_config
# }

module "terraform_state" {
  source = "./Shared-Modules/terraform-state"

  project = var.project
  team    = var.team

  location = var.location
}

module "gke" {
  source = "./Shared-Modules/gke"

  project = var.project
  team    = var.team

  location = var.location

  gke_config = var.gke_config
}

# module "services" {
#   source = "./modules/services"
# }

# module "network" {
#   source = "./modules/network"
#   name = "remla23-team09"
#   vnet_config = var.vnet_config
# }

module "terraform_state" {
  source = "./modules/terraform_state"
  name = "remla23-team09"
  location = var.location
}

module "gke" {
    source = "./modules/gke"
    name = "remla23-team09"
    location = var.location

    gke_config = var.gke_config
}


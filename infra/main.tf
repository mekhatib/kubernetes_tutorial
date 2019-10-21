provider "azurerm" {
  version = "~> 1.34"
}

module "resource-group" {
  source              = "./modules/resource-group"
  resource_group_name = "${var.prefix}-k8s-resources"
  location            = "${var.location}"
}

module "acr" {
  source              = "./modules/acr"
  prefix              = "${var.prefix}"
  location            = "${var.location}"
  resource_group_name = module.resource-group.name
}

module "aks" {
  source              = "./modules/aks"
  prefix              = "${var.prefix}"
  location            = "${var.location}"
  client_id           = "${var.client_id}"
  client_secret       = "${var.client_secret}"
  node_count          = "${var.node_count}"
  vm_size             = "${var.vm_size}"
  os_disk_size_gb     = "${var.os_disk_size_gb}"
  resource_group_name = module.resource-group.name
}

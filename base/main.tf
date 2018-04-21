provider "azurerm" {
  version = "= 1.0"
}

// ---- network

resource "azurerm_resource_group" "network" {
  name     = "${var.name}-network"
  location = "${var.location}"
}

resource "azurerm_virtual_network" "network" {
  name                = "${var.name}"
  address_space       = ["10.0.0.0/16"]
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.network.name}"
}

resource "azurerm_subnet" "network" {
  name                 = "${var.name}"
  resource_group_name  = "${azurerm_resource_group.network.name}"
  virtual_network_name = "${azurerm_virtual_network.network.name}"
  address_prefix       = "10.0.2.0/24"
}

// ---- jumpbox

resource "azurerm_resource_group" "jumpbox" {
  name     = "${var.name}-jumpbox"
  location = "${var.location}"
}

module "jumpbox" {
  source = "github.com/melonproject/terraform-azure-jumpbox"

  name           = "jumpbox"
  location       = "${var.location}"
  resource_group = "${azurerm_resource_group.jumpbox.name}"
  subnet_id      = "${azurerm_subnet.network.id}"
  username       = "${var.username}"
  password       = "${var.password}"
}

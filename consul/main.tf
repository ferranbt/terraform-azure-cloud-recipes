// ---- consul cluster

resource "azurerm_resource_group" "consul" {
  name     = "${var.name}-consul"
  location = "${var.location}"
}

module "consul-server-setup" {
  source = "github.com/melonproject/terraform-azure-consul/modules/server"

  bootstrap_expect = "${var.count}"
  datacenter       = "${var.datacenter}"
  retry_join       = "${var.retry_join}"
}

module "cluster" {
  source = "github.com/melonproject/terraform-azure-consul/modules/cluster"

  name     = "consul"
  location = "${var.location}"

  count          = "${var.count}"
  consul_setup   = "${module.consul-server-setup.setup}"
  resource_group = "${azurerm_resource_group.consul.name}"

  username = "${var.username}"
  password = "${var.password}"

  vm_tier = "${var.vm_tier}"
  vm_name = "${var.vm_name}"

  subnet_id = "${var.subnet_id}"
}

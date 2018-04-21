provider "dnsimple" {
  token   = "${var.dnssimple_token}"
  account = "${var.dnssimple_account}"
}

provider "azurerm" {
  version = "= 1.0"
}

resource "azurerm_resource_group" "cluster" {
  name     = "${var.name}-parity-cluster-${var.chain}"
  location = "${var.location}"
}

module "consul-client" {
  source = "github.com/melonproject/terraform-azure-consul/modules/client"

  datacenter = "${var.datacenter}"
  retry_join = "${var.retry_join}"
}

module "monitor" {
  source = "github.com/melonproject/terraform-azure-parity/modules/monitor"
}

module "setup" {
  source = "github.com/melonproject/terraform-azure-parity/modules/setup"

  user_data      = "${module.consul-client.setup}\n${module.monitor.rendered}"
  username       = "${var.username}"
  genesis        = ""
  chain          = "${var.chain}"
  parity-version = "${var.parity-version}"
  args           = []
}

module "cluster" {
  source = "github.com/melonproject/terraform-azure-parity/modules/cluster"

  name           = "parity-cluster-${var.chain}"
  count          = "${var.count}"
  location       = "${var.location}"
  setup          = "${module.setup.rendered}"
  resource_group = "${azurerm_resource_group.cluster.name}"
  subnet_id      = "${var.subnet_id}"

  disk_space = "${var.disk_space}"

  username = "${var.username}"
  password = "${var.password}"

  vm_name = "${var.vm_name}"
  vm_tier = "${var.vm_tier}"
}

resource "azurerm_resource_group" "lb" {
  name     = "${var.name}-parity-load-balancer-${var.chain}"
  location = "${var.location}"
}

module "load-balancer" {
  source = "github.com/melonproject/terraform-azure-parity/modules/load-balancer"

  name     = "parity-load-balancer"
  location = "${var.location}"

  consul_setup        = "${module.consul-client.setup}"
  parity_service_name = "pool"

  email = "${var.email}"

  subdomain = "${var.subdomain}"
  domain    = "${var.domain}"

  resource_group = "${azurerm_resource_group.lb.name}"
  subnet_id      = "${var.subnet_id}"

  username = "${var.username}"
  password = "${var.password}"
}

output "ip" {
  value = "${module.load-balancer.ip}"
}

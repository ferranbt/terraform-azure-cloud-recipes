output "jumpbox-ip" {
  value = "${module.jumpbox.ip}"
}

output "subnet_id" {
  value = "${azurerm_subnet.network.id}"
}

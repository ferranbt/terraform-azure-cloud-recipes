variable "name" {
  description = "Logical name for the deployment"
}

variable "subnet_id" {
  description = "The subnet id that consul resources will be deployed into"
}

variable "location" {
  description = "The Azure region to deploy the resources"
}

variable "count" {
  description = "Number of parity servers to deploy"
}

variable "disk_space" {
  description = "GB of disk space for each server"
}

// --- parity

variable "chain" {
  description = "Name of the blockchain to sync with (i.e. mainnet, kovan)"
}

variable "parity-version" {
  description = "Version of parity to run"
}

variable "args" {
  description = "List of arguments for parity"
}

// --- consul

variable "datacenter" {
  description = "Consul datacenter"
  default     = "dc1"
}

variable "retry_join" {
  description = "Addresses of other Consul agents to bootstrap"
  default     = ["consul-00001", "consul-000001"]
}

// --- auth

variable "username" {
  description = "Username to access the machines"
  default     = "ubuntu"
}

variable "password" {
  description = "Password to access the machines"
}

// --- vm

variable "vm_tier" {
  description = "Specifies the tier of the virtual machine"
}

variable "vm_name" {
  description = "Specifies the size of the virtual machine"
}

// --- dnssimple

variable "dnssimple_token" {
  description = "DNSimple API v2 token"
}

variable "dnssimple_account" {
  description = "The ID of the account associated with the token"
}

variable "email" {
  description = "Email to send Certbot notifications"
}

variable "subdomain" {
  description = "Subdomain to register the load balancer IP"
}

variable "domain" {
  description = "Domain to register the load balancer IP"
}

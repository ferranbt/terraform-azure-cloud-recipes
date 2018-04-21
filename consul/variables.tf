variable "name" {
  description = "Logical name for the deployment"
}

variable "location" {
  description = "The Azure region to deploy the resources"
}

variable "count" {
  description = "Number of consul servers to deploy. Recommended 3 or 5."
}

variable "datacenter" {
  description = "Consul datacenter"
  default     = "dc1"
}

variable "retry_join" {
  description = "Addresses of other Consul agents to bootstrap"
  default     = ["consul-000001", "consul-000002"]
}

variable "subnet_id" {
  description = "The subnet id that consul resources will be deployed into"
}

// VM

variable "vm_tier" {
  description = "Specifies the tier of the virtual machine"
}

variable "vm_name" {
  description = "Specifies the size of the virtual machine"
}

// auth

variable "username" {
  description = "Username to access the machines"
  default     = "ubuntu"
}

variable "password" {
  description = "Password to access the machines"
}

variable "name" {
  description = "Logical name for the deployment"
}

variable "location" {
  description = "The Azure region to deploy the resources"
}

// Jumpbox auth

variable "username" {
  description = "Username to access the machine"
  default     = "ubuntu"
}

variable "password" {
  description = "Password to access the machine"
}

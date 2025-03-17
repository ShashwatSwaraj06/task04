variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region where resources will be deployed"
  type        = string
  default     = "East US"
}

variable "vnet_name" {
  description = "Name of the virtual network"
  type        = string
}

variable "subnet_name" {
  description = "Name of the subnet"
  type        = string
}

variable "nsg_name" {
  description = "Name of the network security group"
  type        = string
}

variable "public_ip_name" {
  description = "Name of the public IP address"
  type        = string
}

variable "dns_name_label" {
  description = "DNS name label for the public IP"
  type        = string
}

variable "nic_name" {
  description = "Name of the network interface"
  type        = string
}

variable "vm_name" {
  description = "Name of the virtual machine"
  type        = string
}

variable "vm_os_version" {
  description = "OS version for the virtual machine"
  type        = string
  default     = "ubuntu-24_04-lts"
}

variable "vm_sku" {
  description = "SKU for the virtual machine"
  type        = string
  default     = "Standard_F2s_v2"
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
}

variable "vm_password" {
  description = "Password for the virtual machine"
  type        = string
  sensitive   = true
}
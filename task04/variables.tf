variable "resource_group_name" {
  type        = string
  description = "Name of the resource group to provision resources."
}

variable "location" {
  type        = string
  description = "Azure region where resources will be provisioned."
  default     = "eastus"
}

variable "virtual_network_name" {
  type        = string
  description = "Name of the virtual network."
}

variable "subnet_name" {
  type        = string
  description = "Name of the subnet inside the virtual network."
}

variable "public_ip_name" {
  type        = string
  description = "Name of the public IP resource."
}

variable "dns_name_label" {
  type        = string
  description = "DNS label for the public IP resource."
}

variable "nsg_name" {
  type        = string
  description = "Name of the Network Security Group (NSG)."
}

variable "http_rule_name" {
  type        = string
  description = "Name of the HTTP rule in the NSG."
}

variable "ssh_rule_name" {
  type        = string
  description = "Name of the SSH rule in the NSG."
}

variable "network_interface_name" {
  type        = string
  description = "Name of the Network Interface (NIC)."
}

variable "vm_name" {
  type        = string
  description = "Name of the Linux virtual machine."
}

variable "vm_os_version" {
  type        = string
  description = "OS version for the virtual machine."
  default     = "UbuntuLTS"
}

variable "vm_size" {
  type        = string
  description = "Size of the virtual machine (e.g., Standard_F2s_v2)."
  default     = "Standard_F2s_v2"
}

variable "vm_admin_username" {
  type        = string
  description = "Admin username for the VM."
  default     = "azureuser"
}

variable "vm_password" {
  type        = string
  description = "Admin password for the VM."
  sensitive   = true
}

variable "ip_configuration_name" {
  type        = string
  description = "Name of the IP configuration for the NIC."
  default     = "ip_config"
}

variable "tags" {
  type        = map(string)
  description = "Tags to assign to resources."
  default = {
    Creator = "shashwat_swaraj@epam.com"
  }
}
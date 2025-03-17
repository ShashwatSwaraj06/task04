variable "resource_group_name" {
  default = "cmaz-57d8b090-mod4-rg"
}

variable "location" {
  default = "eastus"
}

variable "virtual_network_name" {
  default = "cmaz-57d8b090-mod4-vnet"
}

variable "subnet_name" {
  default = "frontend"
}

variable "public_ip_name" {
  default = "cmaz-57d8b090-mod4-pip"
}

variable "dns_name_label" {
  default = "cmaz-57d8b090-mod4-nginx"
}

variable "nsg_name" {
  default = "cmaz-57d8b090-mod4-nsg"
}

variable "http_rule_name" {
  default = "AllowHTTP"
}

variable "ssh_rule_name" {
  default = "AllowSSH"
}

variable "network_interface_name" {
  default = "cmaz-57d8b090-mod4-nic"
}

variable "vm_name" {
  default = "cmaz-57d8b090-mod4-vm"
}

variable "vm_os_version" {
  default = "UbuntuLTS"
}

variable "vm_size" {
  default = "Standard_F2s_v2"
}

variable "tags" {
  default = {
    Creator = "shashwat_swaraj@epam.com"
  }
}

variable "vm_admin_username" {
  default = "azureuser"
}

variable "vm_password" {
  description = "Admin password for the VM"
  sensitive   = true
}
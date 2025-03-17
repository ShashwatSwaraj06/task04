resource_group_name    = "cmaz-57d8b090-mod4-rg"
location               = "eastus"
virtual_network_name   = "cmaz-57d8b090-mod4-vnet"
subnet_name            = "frontend"
network_interface_name = "cmaz-57d8b090-mod4-nic"
nsg_name               = "cmaz-57d8b090-mod4-nsg"
http_rule_name         = "AllowHTTP"
ssh_rule_name          = "AllowSSH"
public_ip_name         = "cmaz-57d8b090-mod4-pip"
vm_name                = "cmaz-57d8b090-mod4-vm"
dns_name_label         = "cmaz-57d8b090-mod4-nginx"
tags = {
  Creator = "shashwat_swaraj@epam.com"
}
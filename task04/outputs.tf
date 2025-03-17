output "resource_group_id" {
  value       = azurerm_resource_group.rg.id
  description = "The ID of the resource group created."
}

output "vm_public_ip" {
  value       = azurerm_public_ip.pip.ip_address
  description = "The public IP address of the virtual machine."
}

output "vm_fqdn" {
  value       = azurerm_public_ip.pip.fqdn
  description = "The fully qualified domain name (FQDN) of the virtual machine."
}
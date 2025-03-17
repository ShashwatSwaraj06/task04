output "vm_public_ip" {
  value       = azurerm_public_ip.pip.ip_address
  description = "The public IP address of the virtual machine."
}

output "vm_fqdn" {
  value       = azurerm_public_ip.pip.fqdn
  description = "The fully qualified domain name (FQDN) of the virtual machine."
}
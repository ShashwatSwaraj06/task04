# Create the resource group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

# Artificial delay after resource group creation (helps with Azure propagation delays)
resource "null_resource" "delay" {
  depends_on = [azurerm_resource_group.rg]
  provisioner "local-exec" {
    command = "sleep 15" # Delay for 15 seconds
  }
}

# Create the virtual network
resource "azurerm_virtual_network" "vnet" {
  name                = var.virtual_network_name
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]
  tags                = var.tags

  depends_on = [null_resource.delay]
}

# Create the subnet inside the virtual network
resource "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]

  depends_on = [azurerm_virtual_network.vnet]
}

# Create the public IP address
resource "azurerm_public_ip" "pip" {
  name                = var.public_ip_name
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  domain_name_label   = var.dns_name_label
  tags                = var.tags

  depends_on = [null_resource.delay]
}

# Create the network security group
resource "azurerm_network_security_group" "nsg" {
  name                = var.nsg_name
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = var.tags

  depends_on = [null_resource.delay]
}

# Create the HTTP rule for the NSG
resource "azurerm_network_security_rule" "http_rule" {
  name                        = var.http_rule_name
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = 80
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  network_security_group_name = azurerm_network_security_group.nsg.name
  resource_group_name         = azurerm_resource_group.rg.name

  depends_on = [azurerm_network_security_group.nsg]
}

# Create the SSH rule for the NSG
resource "azurerm_network_security_rule" "ssh_rule" {
  name                        = var.ssh_rule_name
  priority                    = 101
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = 22
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  network_security_group_name = azurerm_network_security_group.nsg.name
  resource_group_name         = azurerm_resource_group.rg.name

  depends_on = [azurerm_network_security_group.nsg]
}

# Create the network interface
resource "azurerm_network_interface" "nic" {
  name                = var.network_interface_name
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = var.ip_configuration_name
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip.id
  }

  tags = var.tags

  depends_on = [
    azurerm_subnet.subnet,
    azurerm_public_ip.pip,
    azurerm_network_security_group.nsg
  ]
}

# Associate the NIC with the NSG
resource "azurerm_network_interface_security_group_association" "nsg_association" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id

  depends_on = [azurerm_network_interface.nic]
}

# Create Linux VM with password authentication
resource "azurerm_linux_virtual_machine" "vm" {
  name                            = var.vm_name
  location                        = var.location
  resource_group_name             = azurerm_resource_group.rg.name
  size                            = var.vm_size
  admin_username                  = var.vm_admin_username
  admin_password                  = var.vm_password
  disable_password_authentication = false
  network_interface_ids           = [azurerm_network_interface.nic.id]
  priority                        = "Regular"

  os_disk {
    name                 = "${var.vm_name}-osdisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = 30
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = var.vm_os_version
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update -y",
      "sudo apt install nginx -y",
      "sudo systemctl start nginx",
    ]

    connection {
      type     = "ssh"
      host     = azurerm_public_ip.pip.ip_address
      user     = var.vm_admin_username
      password = var.vm_password
    }
  }

  tags = var.tags

  depends_on = [azurerm_network_interface.nic]
}
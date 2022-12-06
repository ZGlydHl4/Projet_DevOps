resource "azurerm_resource_group" "rg" {
  location = var.resource_group_location
  name     = "carsCredibility"
}

resource "azurerm_virtual_network" "network" {
  name                = "Network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "subnet" {
  name                 = "Subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.network.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_public_ip" "publicIpForLB" {
  name                = "PublicIPForLB"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "networkInterfaces" {
  count               = 4
  name                = "nic${format("%02d", count.index + 1)}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "IpConfiguration"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = count.index == 0 ? azurerm_public_ip.publicIpForLB.id : null
  }
}

resource "azurerm_linux_virtual_machine" "lb" {
  name                  = "lb01"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [element(azurerm_network_interface.networkInterfaces.*.id, 0)]
  size                  = "Standard_DS1_v2"

  os_disk {
    name                 = "osDiskLb01"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  computer_name                   = "lb01"
  admin_username                  = "azureuser"
  disable_password_authentication = true

  admin_ssh_key {
    username   = "azureuser"
    public_key = file(".ssh/id_rsa.pub")
  }
}

resource "azurerm_linux_virtual_machine" "sql" {
  name                  = "sql01"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [element(azurerm_network_interface.networkInterfaces.*.id, 1)]
  size                  = "Standard_DS1_v2"

  os_disk {
    name                 = "osDiskSql01"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  computer_name                   = "sql01"
  admin_username                  = "azureuser"
  disable_password_authentication = true

  admin_ssh_key {
    username   = "azureuser"
    public_key = file(".ssh/id_rsa.pub")
  }
}

resource "azurerm_linux_virtual_machine" "web" {
  count                 = 2
  name                  = "web${format("%02d", count.index + 1)}"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [element(azurerm_network_interface.networkInterfaces.*.id, count.index + 2)]
  size                  = "Standard_DS1_v2"

  os_disk {
    name                 = "osDiskWeb${format("%02d", count.index + 1)}"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  computer_name                   = "web${format("%02d", count.index + 1)}"
  admin_username                  = "azureuser"
  disable_password_authentication = true

  admin_ssh_key {
    username   = "azureuser"
    public_key = file(".ssh/id_rsa.pub")
  }
}

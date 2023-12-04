
resource "azurerm_resource_group" "RG1" {
  name     = "RG1"
  location = "eastus"
  tags     = { env = "dev" }

  lifecycle {
    create_before_destroy = false
  }

}

resource "azurerm_virtual_network" "RG1_network" {
  name                = "RG1_network"
  resource_group_name = azurerm_resource_group.RG1.name
  location            = azurerm_resource_group.RG1.location
  address_space       = ["1.0.0.0/16"]
  tags                = azurerm_resource_group.RG1.tags


}

resource "azurerm_subnet" "RG1_subnet" {
  name                 = "RG1_subnet"
  resource_group_name  = azurerm_resource_group.RG1.name
  virtual_network_name = azurerm_virtual_network.RG1_network.name
  address_prefixes     = ["1.0.1.0/24"]

}

resource "azurerm_network_security_group" "RG1_sg" {
  name                = "RG1-sg"
  resource_group_name = azurerm_resource_group.RG1.name
  location            = azurerm_resource_group.RG1.location
  tags                = azurerm_resource_group.RG1.tags

}

resource "azurerm_network_security_rule" "RG1_sr" {
  name                        = "rule1"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.RG1.name
  network_security_group_name = azurerm_network_security_group.RG1_sg.name
}

resource "azurerm_subnet_network_security_group_association" "RG1_sga" {
  subnet_id                 = azurerm_subnet.RG1_subnet.id
  network_security_group_id = azurerm_network_security_group.RG1_sg.id
}

resource "azurerm_public_ip" "RG1_pubip" {
  name                = "RG1-pubip"
  resource_group_name = azurerm_resource_group.RG1.name
  location            = azurerm_resource_group.RG1.location
  allocation_method   = "Static"
  tags                = azurerm_resource_group.RG1.tags

}

resource "azurerm_network_interface" "RG1_ni" {
  name                = "RG1_ni"
  resource_group_name = azurerm_resource_group.RG1.name
  location            = azurerm_resource_group.RG1.location

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.RG1_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.RG1_pubip.id

  }

}


resource "azurerm_linux_virtual_machine" "RG1_vm" {
  name                = "MyVM"
  resource_group_name = azurerm_resource_group.RG1.name
  location            = azurerm_resource_group.RG1.location
  size                = "Standard_B1s"
  admin_username      = "adminuser"
  /*   admin_password      = "P@ssword" */
  /*  disable_password_authentication = false */
  network_interface_ids = [
    azurerm_network_interface.RG1_ni.id
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  # custom_data = filebase64("templates/custom_data.tpl")


  provisioner "local-exec" {
    command = templatefile("templates/vm_ssh_script.tpl", {
      Hostname = self.public_ip_address,
      User     = self.admin_username
    })
  }

  tags = azurerm_resource_group.RG1.tags

}

# resource "random_string" "sa_code" {
#   length  = 5
#   special = false
#   upper   = false

# }

# resource "azurerm_storage_account" "RG1_storage_account" {
#   name                            = "tfstate${random_string.sa_code.result}"
#   resource_group_name             = azurerm_resource_group.RG1.name
#   location                        = azurerm_resource_group.RG1.location
#   account_tier                    = "Standard"
#   account_replication_type        = "LRS"
#   allow_nested_items_to_be_public = false

# }

# resource "azurerm_storage_container" "RG1_container" {

#   name                  = "tfstate_container"
#   storage_account_name  = azurerm_storage_account.RG1_storage_account.name
#   container_access_type = "private"

# }











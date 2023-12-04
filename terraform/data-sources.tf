data "azurerm_virtual_machine" "RG1_vm" {
  name                = azurerm_linux_virtual_machine.RG1_vm.name
  resource_group_name = azurerm_resource_group.RG1.name

}

data "azurerm_public_ip" "RG1_pu_ipp" {
  name                = azurerm_public_ip.RG1_pubip.name
  resource_group_name = azurerm_resource_group.RG1.name

}
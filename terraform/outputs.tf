output "output" {
  value = "this is the public ip address: ${data.azurerm_virtual_machine.RG1_vm.public_ip_address} and this is the username: ${azurerm_linux_virtual_machine.RG1_vm.admin_username}"

}
data "azurerm_public_ip" "publicIp" {
  name                = "PublicIp"
  resource_group_name = azurerm_resource_group.rg.name
  depends_on          = [azurerm_public_ip.publicIp, azurerm_linux_virtual_machine.lb]
}

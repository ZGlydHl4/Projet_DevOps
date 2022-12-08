output "publicIp" {
  value = data.azurerm_public_ip.publicIp.ip_address
}

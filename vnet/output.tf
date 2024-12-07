output "interfaceid" {
    value = azurerm_network_interface.netinterface[*].id
  
}
output "public_ips" {
  value = azurerm_public_ip.testpublicip[*].id
}

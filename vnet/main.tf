resource "azurerm_virtual_network" "testvnet" {
    name = var.vnetname
    resource_group_name = var.resourcename
    location = var.resourcelocation
    address_space = var.address_space
    

  
}
resource "azurerm_subnet" "Devsubnet" {
    name = "DevSubnet"
    resource_group_name = "rg1"
    virtual_network_name = var.vnetname
    address_prefixes = ["10.0.1.0/24"]
  
}

resource "azurerm_public_ip" "testpublicip" {
  count               = var.vnet_count
  name                = "publi_ip_${count.index}"
  location            = var.resourcelocation
  allocation_method   = "Dynamic"
  resource_group_name = var.resourcename
  sku = "Basic"
}

resource "azurerm_network_interface" "netinterface" {
  count               = var.vnet_count
  name                = "test_interface_${count.index}"
  location            = var.resourcelocation
  resource_group_name = var.resourcename
  
  ip_configuration {
    name                          = "test_ipconfiguration"
    subnet_id                     = azurerm_subnet.Devsubnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.testpublicip[count.index].id  # Corrected index reference
  }
}
resource "azurerm_network_security_group" "TestNSG" {
  name                = var.nsgname
  location            = var.resourcelocation
  resource_group_name = var.resourcename

  # Inbound SSH rule
  security_rule {
    name                       = "Allow-SSH"
    priority                   = 999
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"   # SSH port
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
     name                       = "Allow-http"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"   # SSH port
    source_address_prefix      = "*"
    destination_address_prefix = "*"

  }

  # Outbound Internet Access rule
  security_rule {
    name                       = "Allow-Internet-Outbound"
    priority                   = 1001
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "Internet"
  }

  
  
}
 resource "azurerm_network_interface_security_group_association" "netinterfaceSGassociation" {
    count = var.vnet_count
    network_interface_id = var.nsg_interfaceid[count.index]
    network_security_group_id = azurerm_network_security_group.TestNSG.id
  }
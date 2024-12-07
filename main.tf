provider "azurerm" {
    features {
      
    }
  
}
module "resource" {
    source = "../Modules/resourcerg"
    resourcename = "rg1"
    resourcelocation = "Central India"
  
}
module "network" {
    source = "../Modules/vnet"
    resourcelocation = "Central India"
    resourcename = "rg1"
    address_space = ["10.0.0.0/16"]
    vnetname = "vnet1"
    vnet_count = 2
    nsgname = "testnsg"
    nsg_interfaceid = module.network.interfaceid
}




module "VM" {
    source = "../Modules/vmmodule"
    resource = "rg1"
    location = "Central India"
    vm_count = 2
    vmname = var.vm_names
    interfaceid = module.network.interfaceid
    public_ip = module.network.public_ips
    
  
}
# Terraform Project

#This project demonstrates how to use custom Terraform modules, such as vmmodules, resourcerg, and vnet. It showcases how to call and reuse these modules in different main.tf files to deploy infrastructure efficiently.

It will deploy 12 Resources.

terraform state list   :
```bash
module.VM.azurerm_virtual_machine.TestVM[0]  
module.VM.azurerm_virtual_machine.TestVM[1]
module.network.azurerm_network_interface.netinterface[0]
module.network.azurerm_network_interface.netinterface[1]
module.network.azurerm_network_interface_security_group_association.netinterfaceSGassociation[0]
module.network.azurerm_network_interface_security_group_association.netinterfaceSGassociation[1]
module.network.azurerm_network_security_group.TestNSG
module.network.azurerm_public_ip.testpublicip[0]
module.network.azurerm_public_ip.testpublicip[1]
module.network.azurerm_subnet.Devsubnet
module.network.azurerm_virtual_network.testvnet
module.resource.azurerm_resource_group.Testrg
```

## Requirements

- Terraform >= 0.12
- Azure CLI and Azure Provider for Terraform

## Using Environment Variables

If you prefer not to use the Azure CLI, you can set environment variables to pass your Azure credentials to Terraform. Here are the details for both Bash and PowerShell.

You can set the following environment variables in your terminal:

```bash
export ARM_CLIENT_ID="<your-client-id>"
export ARM_CLIENT_SECRET="<your-client-secret>"
export ARM_SUBSCRIPTION_ID="<your-subscription-id>"
export ARM_TENANT_ID="<your-tenant-id>"
```


```PowerShell
$env:ARM_CLIENT_ID="<your-client-id>"
$env:ARM_CLIENT_SECRET="<your-client-secret>"
$env:ARM_SUBSCRIPTION_ID="<your-subscription-id>"
$env:ARM_TENANT_ID="<your-tenant-id>"
```

Environment Variables Format
You will need to set the following environment variables for Terraform to authenticate with Azure:
```
ARM_CLIENT_ID: The application (client) ID of your Azure service principal.
ARM_CLIENT_SECRET: The secret associated with your Azure service principal.
ARM_SUBSCRIPTION_ID: Your Azure subscription ID.
ARM_TENANT_ID: Your Azure Active Directory tenant ID.
```



  1. **Clone the repository**:
     First, clone the repository to your local machine:


    git clone https://github.com/pr149617/TF
    cd TF 

## **Resourcerg/** : This folder contains a Terraform module that defines resources.

  - `main.tf` : Defines the resources and infrastructure configurations in the module.
  - `variables.tf` : Contains variable definitions used in the `main.tf` file.

## **vmmodule/**: This module defines a resource block for creating multiple Azure Virtual Machines (VMs)

- `main.tf`: This `main.tf` file configures the deployment of Azure resources by calling custom modules such as `vmmodules`, `resourcerg`, and `vnet`. It defines the infrastructure, including the creation of a Resource Group, Virtual Network (VNet), Subnet, Network Security Group (NSG), Network Interface Associations, Public IPs, and Virtual Machines (VMs). The file uses variables to pass values like resource names, locations, and VM details, while also ensuring that the resources are created dynamically based on input variables.

## **VNet Module/** : This Terraform module provisions network resources in Azure, including a Virtual Network (VNet), Subnet, Public IPs, Network Interfaces, and a Network Security Group (NSG) with custom rules. It is designed to set up the foundational networking infrastructure for Azure-based deployments.

`variable.tf`
**resourcename**
Defines the name of the resource group where the Azure resources will be created.

**vnetname**
Specifies the name for the Virtual Network (VNet) to be created.

**vnet_count**
Sets the number of virtual networks, public IPs, and network interfaces to be created based on this value.

`output.tf`
interfaceid
Outputs the IDs of the network interfaces created, enabling easy reference for further configurations.

**public_ips**
Outputs the public IP addresses assigned to the created resources, allowing them to be referenced or used elsewhere.

`main.tf`
**azurerm_virtual_network**
Creates a Virtual Network with a customizable name, address space, and resource group.

**azurerm_network_security_group**
Defines a Network Security Group (NSG) with security rules for controlling inbound and outbound network traffic, such as SSH and HTTP access.

**azurerm_network_interface**
Creates network interfaces associated with subnets and public IPs, with configurations for private and public IP address allocation.


**Root_Module**: This is the main Terraform configuration file where all modules are called. You can view it here: [main.tf](https://github.com/pr149617/TF/blob/main/Root_module/main.tf)



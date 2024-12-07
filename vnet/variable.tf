variable "resourcename" {
    description = "Resource Group name"
  
}
variable "resourcelocation" {
    description = "Location details"
}
variable "vnetname" {
  description = "vnet name "
  type = string
}
variable "address_space" {
    description = "vnet address space"
  
}
variable "vnet_count" {
    type = number
    description = "value for vnet count "
  
}
variable "nsgname" {
  description = "nsgname"
}
variable "nsg_interfaceid" { #checking commit
  
  type = list(string)
}
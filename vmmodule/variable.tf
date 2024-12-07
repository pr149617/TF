variable "resource" {
    description = "resourcegroupname"
    
  
}

variable "interfaceid" {
  description = "interfaceid"
  type = list(string)
}
variable "location" {
  description = "location"
}
variable "public_ip" {
  description = "Public IP address of the virtual machine"
  type        = list(string)
}
variable "vm_count" {
  description = "Number of VMs to create"
  type        = number
  
}
variable "vmname" {
     description = "vmnames"  
     type = list(string)
}
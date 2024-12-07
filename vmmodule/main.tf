
resource "azurerm_virtual_machine" "TestVM" {
    count = var.vm_count
    name = var.vmname[count.index]
    
    resource_group_name = var.resource
    location = var.location
    network_interface_ids = [var.interfaceid[count.index]]
    vm_size = "Standard_D2s_v3"

     delete_os_disk_on_termination = true
     
      tags = {
    Environment = "Test"
    Updated     = "true" # Adding this tag forces an update
  }
   os_profile {
    computer_name  = var.vmname[count.index]   # Name of the VM
    admin_username = "testuser1"              # Replace with your username
  }
    
  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      path = "/home/testuser1/.ssh/authorized_keys"
      key_data = file("D:/Knowledge/terraform/TerraformHandson/terraformkey.pub")
    }
   
    }
    storage_os_disk {
      name              = "osdisk_${var.vmname[count.index]}"
      caching           = "ReadWrite"
      create_option     = "FromImage"
      managed_disk_type = "Standard_LRS"
      disk_size_gb = 100
    }
    storage_image_reference {
      publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
    }
    
    
}
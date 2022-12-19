resource "azurerm_linux_virtual_machine" "myterraformvm" {
  count                 = var.vmcount
  name                  = "myVM-${count.index}"
  resource_group_name   = azurerm_resource_group.myterraformgroup.name
  location              = azurerm_resource_group.myterraformgroup.location
  size                  = "Standard_F2"
  admin_username        = var.admin_username
  admin_password        = var.admin_password
  network_interface_ids = [element(azurerm_network_interface.myterraformnic.*.id, count.index)]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  tags = {
    environment = "developer"
  }
}
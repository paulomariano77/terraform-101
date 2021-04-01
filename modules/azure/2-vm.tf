# Create availability_set
resource "azurerm_availability_set" "avset" {
  name                         = "avset-${var.vm_name}"
  location                     = var.location
  resource_group_name          = azurerm_resource_group.resource_group.name
  platform_fault_domain_count  = 3
  platform_update_domain_count = 5
  managed                      = true

  tags = var.tags
}

# Create virtual machine
resource "azurerm_linux_virtual_machine" "web" {
  count = var.vm_count

  name                  = local.vm_names[count.index]
  location              = var.location
  resource_group_name   = azurerm_resource_group.resource_group.name
  network_interface_ids = [element(azurerm_network_interface.nic.*.id, count.index)]
  size                  = var.vm_size
  availability_set_id   = azurerm_availability_set.avset.id

  os_disk {
    name                 = "osdisk-${local.vm_names[count.index]}-00"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  computer_name                   = local.vm_names[count.index]
  admin_username                  = var.vm_admin_username
  disable_password_authentication = true

  admin_ssh_key {
    username   = var.vm_admin_username
    public_key = file("~/.ssh/id_rsa.pub")
  }

  provisioner "file" {
    source      = "${path.module}/../../scripts/install-nginx.sh"
    destination = "/tmp/install-nginx.sh"

    connection {
      type = "ssh"
      user = var.vm_admin_username
      host = self.public_ip_address
    }
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/install-nginx.sh",
      "/tmp/install-nginx.sh",
    ]

    connection {
      type = "ssh"
      user = var.vm_admin_username
      host = self.public_ip_address
    }
  }

  tags = var.tags
}

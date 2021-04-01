locals {
  vm_names = [for i in range(var.vm_count) : format("%s%02d", var.vm_name, i + 1)]
}

# Create a resource group if it doesn't exist
resource "azurerm_resource_group" "resource_group" {
  name     = var.resource_group
  location = var.location

  tags = var.tags
}

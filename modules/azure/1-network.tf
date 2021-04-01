# Create virtual network
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-test-webapp-${var.location}"
  address_space       = ["192.168.0.0/22"]
  location            = var.location
  resource_group_name = azurerm_resource_group.resource_group.name

  tags = var.tags
}

# Create subnet
resource "azurerm_subnet" "subnet" {
  name                 = "snet-test-webapp"
  resource_group_name  = azurerm_resource_group.resource_group.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["192.168.1.0/24"]
}

# Create Network Security Group and rule
resource "azurerm_network_security_group" "security_group" {
  name                = "nsg-${var.vm_name}"
  location            = var.location
  resource_group_name = azurerm_resource_group.resource_group.name

  security_rule {
    name                       = "AllowSSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowHttp"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = var.tags
}

# Create public IPs
resource "azurerm_public_ip" "public_ip" {
  count = var.vm_count

  name                = "pip-${local.vm_names[count.index]}"
  location            = var.location
  resource_group_name = azurerm_resource_group.resource_group.name
  allocation_method   = "Dynamic"

  tags = var.tags
}

# Create public IP to Load Balancer
resource "azurerm_public_ip" "public_ip_lb" {
  name                = "pip-lb-${var.lb_name}"
  location            = var.location
  resource_group_name = azurerm_resource_group.resource_group.name
  allocation_method   = "Dynamic"
  domain_name_label   = var.lb_name

  tags = var.tags
}

# Create network interface
resource "azurerm_network_interface" "nic" {
  count = var.vm_count

  name                = "nic-${local.vm_names[count.index]}-0"
  location            = var.location
  resource_group_name = azurerm_resource_group.resource_group.name

  ip_configuration {
    name                          = "nicipconf-${local.vm_names[count.index]}-0"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip[count.index].id
  }

  tags = var.tags
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "security_group_association" {
  count = var.vm_count

  network_interface_id      = azurerm_network_interface.nic[count.index].id
  network_security_group_id = azurerm_network_security_group.security_group.id
}

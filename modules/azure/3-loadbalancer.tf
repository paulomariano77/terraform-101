resource "azurerm_lb" "lb" {
  name                = "lb-${var.lb_name}"
  location            = var.location
  resource_group_name = azurerm_resource_group.resource_group.name

  frontend_ip_configuration {
    name                 = "lb-fe-ipconfig-${var.lb_name}"
    public_ip_address_id = azurerm_public_ip.public_ip_lb.id
  }

  tags = var.tags

  depends_on = [azurerm_public_ip.public_ip_lb]
}

resource "azurerm_lb_backend_address_pool" "backend_pool" {
  name            = "lb-be-pool-${var.lb_name}"
  loadbalancer_id = azurerm_lb.lb.id

  depends_on = [azurerm_lb.lb]
}

resource "azurerm_network_interface_backend_address_pool_association" "address_pool_association" {
  count = var.vm_count

  network_interface_id    = azurerm_network_interface.nic[count.index].id
  ip_configuration_name   = "nicipconf-${local.vm_names[count.index]}-0"
  backend_address_pool_id = azurerm_lb_backend_address_pool.backend_pool.id

  depends_on = [
    azurerm_lb_backend_address_pool.backend_pool
  ]
}

resource "azurerm_lb_probe" "lb_probes" {
  resource_group_name = azurerm_resource_group.resource_group.name
  loadbalancer_id     = azurerm_lb.lb.id
  name                = "lb-probe-http-running"
  protocol            = "Tcp"
  port                = 80

  depends_on = [azurerm_lb.lb]
}

resource "azurerm_lb_rule" "lb_rules" {
  resource_group_name            = azurerm_resource_group.resource_group.name
  loadbalancer_id                = azurerm_lb.lb.id
  name                           = "lb-role-tcp-80-to-80"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  backend_address_pool_id        = azurerm_lb_backend_address_pool.backend_pool.id
  probe_id                       = azurerm_lb_probe.lb_probes.id
  frontend_ip_configuration_name = "lb-fe-ipconfig-${var.lb_name}"
  load_distribution              = "Default"

  depends_on = [azurerm_lb.lb]
}

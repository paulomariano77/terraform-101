output "vm_information" {
  value = formatlist(
    "%s = %s",
    (azurerm_linux_virtual_machine.web.*.name),
    (azurerm_linux_virtual_machine.web.*.id)
  )
}

output "vm_private_ip" {
  value = formatlist(
    "%s = %s",
    (azurerm_linux_virtual_machine.web.*.name),
    (azurerm_linux_virtual_machine.web.*.private_ip_address)
  )
}

output "vm_public_ip" {
  value = formatlist(
    "%s = %s",
    (azurerm_linux_virtual_machine.web.*.name),
    (azurerm_linux_virtual_machine.web.*.public_ip_address)
  )
}

output "lb_information" {
  value = formatlist(
    "%s = %s",
    (azurerm_lb.lb.*.name),
    (azurerm_lb.lb.*.id)
  )
}

output "lb_public_ip_addresses" {
  value = formatlist(
    "%v = %v",
    (azurerm_lb.lb.*.name),
    (azurerm_public_ip.public_ip_lb.fqdn)
  )
}

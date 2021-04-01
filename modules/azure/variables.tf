# Global variables
variable "location" {
  description = "Set a location for your new resource. If you do not fill in the default value will be used below."
  default     = "eastus2"
}

variable "resource_group" {
  description = "The name of the resource group."
}

variable "tags" {
  description = "List of tags to be associated to the resources for resources"
  default     = {}
}

# Virtual Machine variables
variable "vm_count" {
  description = "Number of VMs to be created."
  default     = 1
}

variable "vm_name" {
  description = "Set a name for your virtual machine. If you do not fill in the default value will be used below."
  default     = "vm"
}

variable "vm_size" {
  description = "Set a vm size for your virtual machine. If you do not fill in the default value will be used below."
  default     = "Standard_DS1_v2"
}

variable "vm_admin_username" {
  default     = "admin"
  description = "Specifies the name of the local administrator account."
}

# Loadbalance rule variables
variable "lb_name" {
  description = "Set a loadbalance name for your loadbalance. If you do not fill in the default value will be used below."
  default     = "lb"
}

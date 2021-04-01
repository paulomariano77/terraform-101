module "aws" {
  source     = "./modules/aws"
  access_key = var.access_key
  secret_key = var.secret_key

  tags = {
    BusinessUnit = "Terraform101",
    CreatedBy    = "paulomariano77@gmail.com",
    Environment  = "Test",
    Owner        = "paulomariano77@gmail.com",
    Terraform    = true
  }

  instance_count              = 1
  instance_type               = "t3.micro"
  associate_public_ip_address = true
}

module "azure" {
  source = "./modules/azure"

  # Global variables
  location       = "eastus2"
  resource_group = "rg-terraform-101-workstop"

  tags = {
    BusinessUnit = "Terraform101",
    CreatedBy    = "Paulo Mariano (paulomariano77@hotmail.com)",
    Environment  = "Test",
    Owner        = "Paulo Mariano (paulomariano77@gmail.com)",
    Terraform    = true
  }

  # Virtual Machine variables
  vm_count          = 1
  vm_name           = "vm-webapp"
  vm_size           = "Standard_DS1_v2"
  vm_admin_username = "ubuntu"

  # Loadbalance rule variables
  lb_name = "webapp"
}

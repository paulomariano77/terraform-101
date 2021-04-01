# AWS Outputs
output "ec2_information" {
  value = module.aws.ec2_information
}

output "ec2_private_ip" {
  value = module.aws.ec2_private_ip
}

output "ec2_public_ip" {
  value = module.aws.ec2_information
}

output "elb_dns_name" {
  value = module.aws.ec2_public_ip
}

output "elb_name" {
  value = module.aws.elb_name
}

output "elb_instances" {
  value = module.aws.elb_instances
}

# Azure Outputs
output "vm_information" {
  value = module.azure.vm_information
}

output "vm_private_ip" {
  value = module.azure.vm_private_ip
}

output "vm_public_ip" {
  value = module.azure.vm_public_ip
}

output "lb_information" {
  value = module.azure.lb_information
}

output "lb_public_ip_addresses" {
  value = module.azure.lb_public_ip_addresses
}
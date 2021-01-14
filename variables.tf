# Global variables
variable "region" {
  description = "value"
  default     = "us-west-2"
}

variable "access_key" {
  description = "value"
}

variable "secret_key" {
  description = "value"
}

variable "tags" {
  description = "value"
  default = {}
}

# EC2 variables
variable "instance_count" {
  description = "value"
  default = 1
}

variable "instance_type" {
  description = "value"
  default = "t3.micro"
}

variable "associate_public_ip_address" {
  default = true
}

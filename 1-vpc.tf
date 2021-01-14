resource "aws_vpc" "webapp" {
  cidr_block       = "192.168.0.0/22"
  instance_tenancy = "default"

  tags = merge(
    { Name = "vpc-uw2-test-webapp" },
    var.tags
  )
}

resource "aws_subnet" "subnet_webapp" {
  vpc_id                  = aws_vpc.webapp.id
  map_public_ip_on_launch = true
  cidr_block              = "192.168.0.0/24"

  tags = merge(
    { Name = "subnet-uw2-test-webapp" },
    var.tags
  )
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.webapp.id

  tags = merge(
    { Name = "int-gw-uw2-test-webapp" },
    var.tags
  )
}

resource "aws_route_table" "vpc_route_table" {
  vpc_id = aws_vpc.webapp.id

  tags = merge(
    { Name = "rt-uw2-test-webapp" },
    var.tags
  )
}

resource "aws_route" "vpc_internet_access" {
  route_table_id         = aws_route_table.vpc_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.internet_gateway.id
}

resource "aws_route_table_association" "vpc_route_table_association" {
  subnet_id      = aws_subnet.subnet_webapp.id
  route_table_id = aws_route_table.vpc_route_table.id
}

resource "aws_security_group" "allow_ssh" {
  name        = "sg_allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.webapp.id

  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    { Name = "sg_allow_ssh" },
    var.tags
  )
}

resource "aws_security_group" "allow_http" {
  name        = "sg_allow_http"
  description = "Allow HTTP inbound traffic"
  vpc_id      = aws_vpc.webapp.id

  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    { Name = "sg_allow_http" },
    var.tags
  )
}

resource "aws_network_acl" "vpc_security_acl" {
  vpc_id = aws_vpc.webapp.id

  subnet_ids = [
    aws_subnet.subnet_webapp.id
  ]

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 22
    to_port    = 22
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 300
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1024
    to_port    = 65535
  }

  egress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 22
    to_port    = 22
  }

  egress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }

  egress {
    protocol   = "tcp"
    rule_no    = 300
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1024
    to_port    = 65535
  }

  tags = merge(
    { Name = "vpc-acl-uw2-test-webapp" },
    var.tags
  )
}

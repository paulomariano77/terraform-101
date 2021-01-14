data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  count = var.instance_count

  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.subnet_webapp.id
  key_name      = aws_key_pair.aws_key.key_name

  security_groups = [
    aws_security_group.allow_ssh.id,
    aws_security_group.allow_http.id
  ]

  associate_public_ip_address = true

  provisioner "file" {
    source      = "./scripts/install-nginx.sh"
    destination = "/tmp/install-nginx.sh"

    connection {
      type = "ssh"
      user = "ubuntu"
      host = self.public_ip
    }
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/install-nginx.sh",
      "/tmp/install-nginx.sh",
    ]

    connection {
      type = "ssh"
      user = "ubuntu"
      host = self.public_ip
    }
  }

  depends_on = [
    aws_vpc.webapp,
    aws_subnet.subnet_webapp,
    aws_internet_gateway.internet_gateway,
    aws_route.vpc_internet_access
  ]

  tags = merge(
    { Name = format("ec2-uw2-test-webapp%02d", count.index + 1) },
    var.tags
  )
}

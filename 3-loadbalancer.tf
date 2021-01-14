module "elb_http" {
  source  = "terraform-aws-modules/elb/aws"
  version = "~> 2.0"

  name = "elb-uw2-test-webapp"

  subnets         = [aws_subnet.subnet_webapp.id]
  security_groups = [aws_security_group.allow_http.id]
  internal        = false

  listener = [
    {
      instance_port     = "80"
      instance_protocol = "HTTP"
      lb_port           = "80"
      lb_protocol       = "HTTP"
    }
  ]

  health_check = {
    target              = "HTTP:80/"
    interval            = 30
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
  }

  number_of_instances = var.instance_count
  instances           = [for i in range(var.instance_count) : aws_instance.web[i].id]

  depends_on = [
    aws_instance.web
  ]

  tags = var.tags
}

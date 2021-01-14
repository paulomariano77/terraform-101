output "ec2_information" {
  value = "${formatlist(
    "%s = %s",
    (aws_instance.web.*.id),
    (aws_instance.web.*.id)
  )}"
}

output "ec2_private_ip" {
  value = "${formatlist(
    "%s = %s",
    (aws_instance.web.*.id),
    (aws_instance.web.*.private_ip)
  )}"
}

output "ec2_public_ip" {
  value = "${formatlist(
    "%s = %s",
    (aws_instance.web.*.id),
    (aws_instance.web.*.public_ip)
  )}"
}

output "elb_dns_name" {
  value = module.elb_http.this_elb_dns_name
}

output "elb_name" {
  value = module.elb_http.this_elb_name
}

output "elb_instances" {
  value = module.elb_http.this_elb_instances
}

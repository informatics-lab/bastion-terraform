output "public_ip" {
  value = "${aws_instance.bastion.public_ip}"
}

output "allowed_security_group" {
  value = "${aws_security_group.allow_bastion.name}"
}

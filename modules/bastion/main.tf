resource "aws_security_group" "bastion" {
  name        = "bastion"
  description = "Allow ssh to bastion host"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.allowed_networks}"]
  }

  ingress {
    from_port   = 993 
    to_port     = 993
    protocol    = "tcp"
    cidr_blocks = ["${var.allowed_networks}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "allow_bastion" {
  name        = "allow_from_bastion"
  description = "Allow access from bastion host"

  ingress {
    from_port       = 0
    to_port         = 65335
    protocol        = "tcp"
    security_groups = ["${aws_security_group.bastion.id}"]
  }
}

resource "aws_instance" "bastion" {
  ami           = "ami-f1949e95" # Amazon Linux
  instance_type = "t2.micro"
  key_name      = "${var.key_name}"

  security_groups = ["${aws_security_group.bastion.name}"]

  associate_public_ip_address = true

  user_data = "${file("${path.module}/files/bootstrap.sh")}"

  tags {
    Name = "bastion"
  }

}

# modules/ec2_instance/main.tf
resource "aws_instance" "web_instance" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name
  vpc_security_group_ids = [var.security_group_id]
  tags = {
    Name = var.instance_name
  }
}

output "instance_id" {
  value = aws_instance.web_instance.id
}

output "instance_public_ip" {
  value = aws_instance.web_instance.public_ip
}


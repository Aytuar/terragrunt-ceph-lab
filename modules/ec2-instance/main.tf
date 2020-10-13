resource "aws_instance" "instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = var.subnet_id
  user_data     = var.user_data
  monitoring    = var.monitoring

  tags = {
    Name = var.name
  }

  vpc_security_group_ids = var.sg_ids

  volume_tags = {
    Name = var.name
  }
}

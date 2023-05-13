data "aws_ami" "ego_fisdn_server_ami" {
  most_recent = true
  owners      = ["137112412989"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.0.20230419.0-kernel-6.1-x86_64"]
  }
}

data "template_cloudinit_config" "user-data" {

  part {
    filename     = "init-script.sh"
    content_type = "text/x-shellscript"

    content = file("${path.module}/user-data/init-script.sh")
  }

}

resource "aws_key_pair" "ego_fisdn_server_auth" {
  key_name   = "ego_fisdn_server_key"
  public_key = file("~/.ssh/ego_fisdn_server_key.pub")
}

resource "aws_instance" "ego_fisdn_server" {
  instance_type          = "t3.micro"
  ami                    = data.aws_ami.ego_fisdn_server_ami.id
  vpc_security_group_ids = [aws_security_group.ego_sg.id]
  subnet_id              = aws_subnet.ego_public_subnet.id
  key_name               = aws_key_pair.ego_fisdn_server_auth.id
  user_data              = data.template_cloudinit_config.user-data.rendered

  root_block_device {  
    volume_size = 8
  }
  tags = {
    Name = "ego_fisdn_server"
  }
}

# OUTPUT
output "aws_instance_public_dns" {
  value = aws_instance.ego_fisdn_server.public_dns
}


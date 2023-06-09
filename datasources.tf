# Select an ami
data "aws_ami" "ego_server_ami" {
  most_recent = true
  owners      = ["137112412989"]

  filter {
    name   = "name"
    values = ["amzn2-ami-amd-hvm-2.0.20230515.0-x86_64-gp2"]
  }
}

# Setup the user-data
data "template_cloudinit_config" "user-data" {

  part {
    filename     = "init-script.sh"
    content_type = "text/x-shellscript"

    content = file("${path.module}/user-data/init-script.sh")
  }

}

# Setup the ssh key-pair
variable "ego_server_name" {
 default = "secret"
}

resource "aws_key_pair" "ego_server_auth" {
  key_name   = "${var.ego_server_name}_key"
  public_key = file("~/.ssh/${var.ego_server_name}_key.pub")
}

# Setup the instance
resource "aws_instance" "ego_server" {
  instance_type          = "t3.micro"
  ami                    = data.aws_ami.ego_server_ami.id
  vpc_security_group_ids = [aws_security_group.ego_sg.id]
  subnet_id              = aws_subnet.ego_public_subnet.id
  key_name               = aws_key_pair.ego_server_auth.id
  user_data              = data.template_cloudinit_config.user-data.rendered

  root_block_device {  
    volume_size = 8
  }
  tags = {
    Name = "${var.ego_server_name}"
  }
}

# Associate the instance with our elastic IP
variable "ego_elastic_ip" {
 default = "secret"
}

data "aws_eip" "ego_server_eip" {
  public_ip = "${var.ego_elastic_ip}"
}

resource "aws_eip_association" "ego_server_eip_association" {
  instance_id   = aws_instance.ego_server.id
  allocation_id = data.aws_eip.ego_server_eip.id
}

# OUTPUT
output "aws_instance_ip" {
  value = aws_instance.ego_server.public_dns
}

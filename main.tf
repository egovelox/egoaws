resource "aws_vpc" "ego_vpc" {
  cidr_block           = "10.123.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "ec2_ego_vpc"
  }
}

resource "aws_subnet" "ego_public_subnet" {
  vpc_id                  = aws_vpc.ego_vpc.id
  cidr_block              = "10.123.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "eu-central-1a"

  tags = {
    Name = "ego-public"
  }
}

resource "aws_internet_gateway" "ego_internet_gateway" {
  vpc_id = aws_vpc.ego_vpc.id

  tags = {
    Name = "ego-igw"
  }
}

resource "aws_route_table" "ego_public_rt" {
  vpc_id = aws_vpc.ego_vpc.id

  tags = {
    Name = "ego_public_rt"
  }
}

resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.ego_public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.ego_internet_gateway.id
}

resource "aws_route_table_association" "my_public_assoc" {
  subnet_id      = aws_subnet.ego_public_subnet.id
  route_table_id = aws_route_table.ego_public_rt.id
}

resource "aws_security_group" "ego_sg" {
  name        = "ego_sg"
  description = "ego security group: allow ssh + http(s)"
  vpc_id      = aws_vpc.ego_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] 
  }
}

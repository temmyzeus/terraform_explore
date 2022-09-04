resource "aws_vpc" "dev_env_vpc" {
  cidr_block           = "10.123.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    "Name" = "dev-env"
  }
}

resource "aws_subnet" "dev_env_subnet" {
  vpc_id                  = aws_vpc.dev_env_vpc.id
  cidr_block              = "10.123.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-west-2a"
  tags = {
    "Name" = "dev-env"
  }
  depends_on = [
    aws_vpc.dev_env_vpc
  ]
}

resource "aws_internet_gateway" "dev_env_internet_gateway" {
  vpc_id = aws_vpc.dev_env_vpc.id
  tags = {
    "Name" = "dev-env"
  }
  depends_on = [
    aws_vpc.dev_env_vpc
  ]
}

resource "aws_route_table" "dev_env_route_table" {
  vpc_id = aws_vpc.dev_env_vpc.id
  tags = {
    "Name" = "dev-env-rt"
  }
}

resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.dev_env_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.dev_env_internet_gateway.id
}

resource "aws_route_table_association" "name" {
  route_table_id = aws_route_table.dev_env_route_table.id
  subnet_id      = aws_subnet.dev_env_subnet.id
}

resource "aws_security_group" "default_sg" {
  name        = "dev_env_sg"
  description = "Dev Env security group"
  vpc_id      = aws_vpc.dev_env_vpc.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Access the open internet"
  }
  tags = {
    "Name" = "dev-end-security-group"
  }
}

resource "aws_key_pair" "name" {
  key_name   = "dev_env_key"
  public_key = file(var.private_key_path)
}

resource "aws_instance" "dev_env" {
  ami                         = data.aws_ami.ec2_server_ami.id
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.name.key_name
  vpc_security_group_ids      = [aws_security_group.default_sg.id]
  subnet_id                   = aws_subnet.dev_env_subnet.id
  user_data                   = file("userdata.tpl")
  user_data_replace_on_change = false
  root_block_device {
    volume_size = 10
  }
  tags = {
    "Name" = "dev-env-server"
  }
}
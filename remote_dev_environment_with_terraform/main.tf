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

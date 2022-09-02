terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region                   = "us-west-2"
  shared_credentials_files = ["$HOME/.aws/credentials"]
  profile                  = "remote_dev_env"
}

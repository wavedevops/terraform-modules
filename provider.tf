#provider.tf
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.13.0"
    }
  }
}
provider "aws" {
  region = "us-east-1"
}

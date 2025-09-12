terraform {
  backend "s3" {
    bucket         = "chowdary-hari"
    key            = "vpc/dev/terraform.tfstate"
    region         = "us-east-1"
  }
}

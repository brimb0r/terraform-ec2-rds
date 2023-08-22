provider "aws" {
  region = "us-east-1"
}

terraform {

  backend "s3" {
    encrypt        = true
    bucket         = "subprod-terraform-state-store-us-east-1"
    dynamodb_table = "subprod-state-store"
    key            = "dev-ec2-us-east-1.tfstate"
    region         = "us-east-1"
  }

  required_version = ">=0.14"
}

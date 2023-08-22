module "vpc" {
  source              = "../../../../mod/networking"
  environment         = "dev"
  priv_one_az         = "us-east-1e"
  priv_one_cidr_block = "10.0.2.0/25"
  priv_two_az         = "us-east-1d"
  priv_two_cidr_block = "10.0.2.128/25"
  public_one_az       = "us-east-1d"
  pub_one_cidr_block  = "10.0.1.0/25"
  public_two_az       = "us-east-1e"
  pub_two_cidr_block  = "10.0.1.128/25"
  region              = "us-east-1"
  vpc_cidr_block      = "10.0.0.0/16"
}
module "rds" {
  source              = "../../../../mod/rds/mysql"
  engine_version      = "5.7"
  instance_class      = "db.t2.micro"
  priv_one_sub_cidr_block = data.terraform_remote_state.vpc.outputs.priv_one_cidr
  priv_two_sub_cidr_block = data.terraform_remote_state.vpc.outputs.priv_two_cidr
  user_name           = "adminInit"
  vpc_id              = data.terraform_remote_state.vpc.outputs.aws_vpc
  priv_one_sub_id = data.terraform_remote_state.vpc.outputs.private_one
  priv_two_sub_id = data.terraform_remote_state.vpc.outputs.private_two
}
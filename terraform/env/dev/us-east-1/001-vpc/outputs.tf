output "aws_security_groupegress_all" {
  value = module.vpc.aws_security_groupegress_all
}
output "aws_security_grouphttp" {
  value = module.vpc.aws_security_grouphttp
}
output "aws_security_grouphttps" {
  value = module.vpc.aws_security_grouphttps
}
output "aws_vpc" {
  value = module.vpc.aws_vpc
}
output "private_one" {
  value = module.vpc.private_one
}
output "public_one" {
  value = module.vpc.public_one
}
output "priv_one_cidr" {
  value = module.vpc.priv_one_cidr
}
output "pub_one_cidr" {
  value = module.vpc.public_one_cidr
}

output "private_two" {
  value = module.vpc.private_two
}
output "public_two" {
  value = module.vpc.public_two
}
output "priv_two_cidr" {
  value = module.vpc.priv_two_cidr
}
output "pub_two_cidr" {
  value = module.vpc.public_two_cidr
}
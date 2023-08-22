output "aws_security_groupegress_all" {
  value = aws_security_group.egress_all.id
}
output "aws_security_grouphttp" {
  value = aws_security_group.http.id
}
output "aws_security_grouphttps" {
  value = aws_security_group.https.id
}
output "aws_vpc" {
  value = aws_vpc.app_vpc.id
}
output "private_one" {
  value = aws_subnet.private_one.id
}
output "public_one" {
  value = aws_subnet.public_one.id
}
output "public_one_cidr" {
  value = var.pub_one_cidr_block
}
output "priv_one_cidr" {
  value = var.priv_one_cidr_block
}

output "private_two" {
  value = aws_subnet.private_two.id
}
output "public_two" {
  value = aws_subnet.public_two.id
}
output "public_two_cidr" {
  value = var.pub_two_cidr_block
}
output "priv_two_cidr" {
  value = var.priv_two_cidr_block
}
#create a security group for RDS Database Instance
resource "aws_security_group" "rds_sg_mysql" {
  name = "rds_sg"
  vpc_id = var.vpc_id
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [var.priv_one_sub_cidr_block, var.priv_two_sub_cidr_block]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#create a RDS Database Instance
resource "aws_db_instance" "mysql_instance" {
  engine                 = "mysql"
  identifier             = "myrdsinstance"

  allocated_storage      = 20
  engine_version         = var.engine_version
  instance_class         = var.instance_class
  username               = var.user_name
  password               = "ChangeMeInUiAfterApply"
  parameter_group_name   = "default.mysql5.7"
  vpc_security_group_ids = [aws_security_group.rds_sg_mysql.id]
  skip_final_snapshot    = true
  publicly_accessible    = false
  db_subnet_group_name = aws_db_subnet_group.mysql.name
  lifecycle {
    ignore_changes = [password]
  }
}

resource "aws_db_subnet_group" "mysql" {
  subnet_ids = [var.priv_one_sub_id, var.priv_two_sub_id]

}
resource "aws_security_group" "bastion_sg" {
  name        = "bastion-sg"
  description = "Security group for bastion host"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Replace with your specific IP range for SSH access // set to openfor now
  }

  egress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [data.terraform_remote_state.vpc.outputs.priv_one_cidr, data.terraform_remote_state.vpc.outputs.priv_two_cidr]
  }


  vpc_id = data.terraform_remote_state.vpc.outputs.aws_vpc
}

resource "aws_security_group" "app_server_sg" {
  name        = "app-server-sg"
  description = "Security group for application server"

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion_sg.id]
  }

  egress {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks = [data.terraform_remote_state.vpc.outputs.priv_one_cidr, data.terraform_remote_state.vpc.outputs.priv_two_cidr]
  }

  vpc_id = data.terraform_remote_state.vpc.outputs.aws_vpc
}
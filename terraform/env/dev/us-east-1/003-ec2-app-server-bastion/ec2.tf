// This has assumed you have set up a key pair in AWS either manually or with terraform && ssh-keygen
// I generated mine in the aws UI
// Ensure that your file perms are 600 e.g chmod 600 your_file_name.pem
// Save the file to copy to your EC2 instance ( not safe to put in user data!! )

# Bastion host
resource "aws_instance" "bastion_host" {
  ami                         = "ami-0453898e98046c639" // this is hard coded but really you would want to use a data source
  instance_type               = "t2.micro"
  key_name                    = "bastion-Key"
  subnet_id                   = data.terraform_remote_state.vpc.outputs.public_one
  vpc_security_group_ids      = [aws_security_group.bastion_sg.id]
  associate_public_ip_address = true

  tags = {
    "Name" = "bastion"
  }
}

module "app_log_bucket" {
  source      = "./s3"
  environment = "dev"
  region      = "us-east-1"
}

# Application server
resource "aws_instance" "app_server" {
  ami           = "ami-0453898e98046c639"
  instance_type = "t2.micro" # Replace with your desired instance type
  key_name      = "bastion-Key"

  subnet_id              = data.terraform_remote_state.vpc.outputs.private_one
  vpc_security_group_ids = [aws_security_group.app_server_sg.id]

  iam_instance_profile = aws_iam_instance_profile.instance_profile.name

  tags = {
    "Name" = "app_server"
  }

  depends_on = [module.app_log_bucket, aws_instance.bastion_host]
}
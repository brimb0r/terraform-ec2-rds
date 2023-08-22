resource "aws_vpc" "app_vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    "Name" = format("%s-%s-vpc", var.environment, var.region)
  }
}

resource "aws_subnet" "public_one" {
  vpc_id            = aws_vpc.app_vpc.id
  cidr_block        = var.pub_one_cidr_block
  availability_zone = var.public_one_az

  tags = {
    "Name" = format("public | %s", var.public_one_az)
  }
}

resource "aws_subnet" "private_one" {
  vpc_id            = aws_vpc.app_vpc.id
  cidr_block        = var.priv_one_cidr_block
  availability_zone = var.priv_one_az

  tags = {
    "Name" = format("private | %s", var.priv_one_az)
  }
}

resource "aws_subnet" "public_two" {
  vpc_id            = aws_vpc.app_vpc.id
  cidr_block        = var.pub_two_cidr_block
  availability_zone = var.public_two_az

  tags = {
    "Name" = "public | us-east-1d"
  }
}

resource "aws_subnet" "private_two" {
  vpc_id            = aws_vpc.app_vpc.id
  cidr_block        = var.priv_two_cidr_block
  availability_zone = var.priv_two_az

  tags = {
    "Name" = format("private | %s", var.priv_two_az)
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.app_vpc.id
  tags = {
    "Name" = "public"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.app_vpc.id
  tags = {
    "Name" = "private"
  }
}

resource "aws_route_table_association" "public_one_subnet" {
  subnet_id      = aws_subnet.public_one.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private_one_subnet" {
  subnet_id      = aws_subnet.private_one.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "public_two_subnet" {
  subnet_id      = aws_subnet.public_two.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private_two_subnet" {
  subnet_id      = aws_subnet.private_two.id
  route_table_id = aws_route_table.private.id
}

resource "aws_eip" "nat" {
  vpc = true
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.app_vpc.id
}

resource "aws_nat_gateway" "ngw" {
  subnet_id     = aws_subnet.public_one.id
  allocation_id = aws_eip.nat.id

  depends_on = [aws_internet_gateway.igw]
}

resource "aws_route" "public_igw" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route" "private_ngw" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.ngw.id
}

resource "aws_security_group" "http" {
  name        = "http"
  description = "HTTP traffic"
  vpc_id      = aws_vpc.app_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "https" {
  name        = "https"
  description = "HTTPS traffic"
  vpc_id      = aws_vpc.app_vpc.id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "egress_all" {
  name        = "egress-all"
  description = "Allow all outbound traffic"
  vpc_id      = aws_vpc.app_vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

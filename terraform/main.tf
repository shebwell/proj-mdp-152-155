resource "aws_vpc" "main_vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "production-vpc"
  }
}

resource "aws_subnet" "public_subnet_az1" {
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = var.public_subnet_az1
  availability_zone = "us-east-1a"

  tags = {
    Name = "public-subnet-az1"
  }
}

resource "aws_subnet" "public_subnet_az2" {
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = var.public_subnet_az2
  availability_zone = "us-east-1b"

  tags = {
    Name = "public-subnet-az2"
  }
}

resource "aws_security_group" "allow_all" {
  name        = "allow_all"
  description = "Allow all traffic"
  vpc_id      = aws_vpc.main_vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "control_plane" {
  ami           = "ami-0c7217cdde317cfec"
  instance_type = var.instance_type
  subnet_id     = aws_subnet.public_subnet_az1.id
  key_name      = var.key_name
  vpc_security_group_ids = [aws_security_group.allow_all.id]

  tags = {
    Name = "control-plane-node"
  }
}

resource "aws_instance" "worker_node" {
  ami           = "ami-0c7217cdde317cfec"
  instance_type = var.instance_type
  subnet_id     = aws_subnet.public_subnet_az2.id
  key_name      = var.key_name
  vpc_security_group_ids = [aws_security_group.allow_all.id]

  tags = {
    Name = "worker-node"
  }
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  default     = "10.0.0.0/16"
}

variable "public_subnet_az1_cidr" {
  description = "Public Subnet AZ1"
  default     = "10.0.1.0/24"
}

variable "public_subnet_az2_cidr" {
  description = "Public Subnet AZ2"
  default     = "10.0.2.0/24"
}

variable "region" {
  description = "AWS Region"
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 Instance Type"
  default     = "t3.medium"
}

variable "key_name" {
  description = "Name of the existing EC2 Key Pair"
}

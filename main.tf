provider "aws" {
  region = var.aws_region
}

resource "aws_vpc" "example" {
  cidr_block           = "10.0.0.0/16" 
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "example-vpc"
  }
}

resource "aws_security_group" "web_sg" {
  name        = "web_sg"
  description = "Web server security group"
  vpc_id      = aws_vpc.example.id

  ingress {
    description = "Allow HTTP traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTPS traffic"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web-sg"
  }
}

variable "aws_region" {
  default = "us-east-1"
  description = "AWS region to deploy resources"
}

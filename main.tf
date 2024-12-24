   provider "aws" {
          region = "us-east-1"
        }

        resource "aws_vpc" "example" {
          cidr_block = "10.0.0.0/16"
        }

        resource "aws_security_group" "web_sg" {
          name        = "web_sg"
          description = "Web server security group"
          vpc_id      = aws_vpc.example.id

          ingress {
            from_port   = 80
            to_port     = 80
            protocol    = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
          }

          egress {
            from_port   = 0
            to_port     = 0
            protocol    = "-1"
            cidr_blocks = ["0.0.0.0/0"]
          }
        }

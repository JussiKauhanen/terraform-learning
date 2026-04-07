# main.tf

# Configure the AWS provider
provider "aws" {
  region = var.aws_region
}

# Data source: get your current IP address (for SSH access)
data "http" "my_ip" {
  url = "https://checkip.amazonaws.com"
}

# Variable definitions
variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "Name of the EC2 key pair (must exist in your AWS account)"
  type        = string
  default     = ""  # You'll need to change this or create a key pair
}

# Security group allowing SSH from your IP
resource "aws_security_group" "web_sg" {
  name        = "terraform-ec2-sg"
  description = "Allow SSH inbound traffic"
  vpc_id      = "vpc-08e5397b1141687ea"   # <-- add your VPC ID here

  ingress {
    description = "SSH from my IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${chomp(data.http.my_ip.response_body)}/32"]
  }

  ingress {
    description = "HTTP from anywhere"
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

  tags = {
    Name = "terraform-ec2-sg"
    Environment = "learning"
  }
}

# EC2 instance
resource "aws_instance" "web" {
  ami                    = data.aws_ami.amazon_linux_2.id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y httpd
    systemctl start httpd
    systemctl enable httpd
    echo "<h1>Hello from Terraform at $(hostname -f)</h1>" > /var/www/html/index.html
  EOF

  tags = {
    Name = "terraform-ec2-demo"
    Environment = "learning"
  }
}

# Data source: get the latest Amazon Linux 2 AMI
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# Outputs
output "instance_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.web.public_ip
}

output "security_group_id" {
  description = "ID of the created security group"
  value       = aws_security_group.web_sg.id
}

output "web_server_url" {
  description = "URL to access the web server"
  value       = "http://${aws_instance.web.public_ip}"
}
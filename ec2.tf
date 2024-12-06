# Define the AWS provider
provider "aws" {
  region = "us-east-1" # Replace with your preferred AWS region
}

# Define a security group for the EC2 instance
resource "aws_security_group" "ec2_security_group" {
  name        = "ec2-security-group"
  description = "Allow SSH and HTTP inbound traffic"

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
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
    Name = "EC2 Security Group"
  }
}

# Define the EC2 instance
resource "aws_instance" "web_server" {
  ami           = "ami-0c02fb55956c7d316" # Replace with the AMI ID for your region
  instance_type = "t2.micro"
  key_name      = "my-key-pair" # Replace with your key pair name

  # Attach the security group
  security_groups = [aws_security_group.ec2_security_group.name]

  # Add a basic tag
  tags = {
    Name = "Terraform-EC2"
  }
}

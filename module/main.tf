# Subnets of the EC2 instances
data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }

  tags = {
    Tier = "Private"
  }
}

# Find an official Ubuntu AMI
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  owners = ["099720109477"] # Canonical official
}

# EC2 instance
resource "aws_instance" "ec2_example" {
  for_each      = toset(data.aws_subnets.private.ids)
  ami = data.aws_ami.ubuntu
  instance_type = "t2.micro"
  key_name= var.key_name
  vpc_security_group_ids = [aws_security_group.ssh.id]
  subnet_id = each.value
}
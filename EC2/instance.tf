provider "aws" {
  region = "us-east-1"
  shared_credentials_file= "/home/victor/.aws/credentials"
  profile = "digiage"
  
}

resource "aws_instance" "web" {
  ami             = "ami-05ecb1463f8f1ee4b"
  instance_type   = "t2.micro"
  key_name        = "${aws_key_pair.my-key.key_name}"
  security_groups = ["${aws_security_group.allow_ssh.name}"] 
}

resource "aws_key_pair" "my-key" {
  key_name   = "my-key"
  public_key = "${file("~/.ssh/id_rsa.pub")}"
  
}

resource "aws_security_group" "allow_ssh" {
  name = "allow_ssh"
  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress{
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
}

output "example_public_dns" {
  value = "${aws_instance.web.public_dns}"
}
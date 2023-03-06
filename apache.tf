resource "aws_instance" "apache_server" {
  ami                    = "ami-006dcf34c09e50022"
  instance_type          = "t2.micro"
  subnet_id              = "subnet-020655c8fb9b303dc"
  key_name               = aws_key_pair.public_key.id
  vpc_security_group_ids = [aws_security_group.apache_sg.id]
  user_data = file("apache-userdata.sh")
 tags = {
    Name = "apache"
  }
} 


resource "aws_security_group" "apache_sg" {
  name        = "apache-server"
  description = "Allow TLS inbound traffic"
  vpc_id      = "vpc-01e8bd715ca6b33cd"

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "apache-server"
  }
}
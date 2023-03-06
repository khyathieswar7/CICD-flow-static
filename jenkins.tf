resource "aws_security_group" "jenkins_sg" {
  name        = "jenkins-server"
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
    from_port   = 8080
    to_port     = 8080
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
    Name = "jenkins-server"
  }
}
resource "aws_instance" "jenkins_server" {
  ami                    = "ami-006dcf34c09e50022"
  instance_type          = "t2.xlarge"
  subnet_id              = "subnet-020655c8fb9b303dc"
  key_name               = aws_key_pair.public_key.id
  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]
  user_data = <<EOF
  sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
sudo yum upgrade -y 
# Add required dependencies for the jenkins package
sudo yum install java-11-openjdk -y
sudo amazon-linux-extras install java-openjdk11
sudo yum install jenkins -y
systemctl enable jenkins
systemctl start jenkins
EOF
tags = {
    Name = "jenkins"
  }
}
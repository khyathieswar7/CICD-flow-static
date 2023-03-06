resource "aws_instance" "jenkins_server" {
  ami                    = "ami-006dcf34c09e50022"
  instance_type          = "t2.micro"
  subnet_id              = "subnet-020655c8fb9b303dc"
  key_name               = aws_key_pair.public_key.id
  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]
 tags = {
    Name = "jenkins"
  }
}
 
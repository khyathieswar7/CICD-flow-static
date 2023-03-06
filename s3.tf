resource "aws_s3_bucket" "cicd_khyathi_static1" {
  bucket = "cicd-khyathi-static1"

  tags = {
    Name        = "cicd_static"
    Environment = "dev"
  }
}
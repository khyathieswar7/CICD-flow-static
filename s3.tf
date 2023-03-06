resource "aws_s3_bucket" "cicd_khyathi_static" {
  bucket = "cicd-khyathi-static"

  tags = {
    Name        = "cicd_static"
    Environment = "dev"
  }
}
# create a role 
resource "aws_iam_role" "jenkins_to_s3" {
  name = "jenkins_to_s3"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    tag-key = "jenkins_to_s3"
  }
}

# create a policy

resource "aws_iam_policy" "jenkins_to_s3_policy" {
  name        = "test_policy"
  path        = "/"
  description = "My test policy"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:*",
          "ecr:*"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}




resource "aws_iam_role_policy_attachment" "jenkin_to_s3_cicd_role" {
  role       = aws_iam_role.jenkins_to_s3.name
  policy_arn = aws_iam_policy.jenkins_to_s3_policy.arn
}

resource "aws_iam_instance_profile" "jenkins_to_s3_policy_iam" {
  name = "test_profile"
  role = aws_iam_role.jenkins_to_s3.name
}
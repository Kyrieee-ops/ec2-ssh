#------------------------------------
# IAM Role
#------------------------------------
data "aws_iam_policy" "s3_read_only" {
  name = "AmazonS3ReadOnlyAccess"
}

resource "aws_iam_role" "s3_bucket_policy" {
  name = "s3-role-for-tfstate"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "allow_read_s3_bucket_policy" {
  role       = aws_iam_role.s3_bucket_policy.name
  policy_arn = data.aws_iam_policy.s3_read_only.arn
}

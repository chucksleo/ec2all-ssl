resource "aws_s3_bucket" "s3" {
  bucket = var.bucket_name

  tags = {
    Name        = "${var.name_prefix}-${var.name_suffix}-s3"
  }
}

resource "aws_iam_policy" "s3_policy" {
  name        = "s3policy"
  description = "S3 bucket policy for read, write, list, and put operations"
  
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:ListBucket",
        
        ],
        Effect   = "Allow",
        Resource = [
          aws_s3_bucket.s3.arn,
          "${aws_s3_bucket.s3.arn}/*",
        ],
      },
    ],
  })
}

resource "aws_iam_policy_attachment" "policy_attachment" {
  name       = "s3--policy-attachment"
  policy_arn = aws_iam_policy.s3_policy.arn
  groups = [ "Administrator" ]

}
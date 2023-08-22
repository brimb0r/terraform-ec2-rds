# create an S3 bucket to store the state file in
resource "aws_s3_bucket" "dev-app-log-bucket" {
  bucket = format("app-log-bucket-%s-%s", var.environment, var.region)
  tags = {
    Name = format("app-log-bucket-%s-%s", var.environment, var.region)
  }
}

resource "aws_s3_bucket_object" "dev-app-log-bucket" {
  key                    = format("env:/%v/", "app-logs")
  bucket                 = aws_s3_bucket.dev-app-log-bucket.id
  source                 = "/dev/null"
  server_side_encryption = "AES256"
}
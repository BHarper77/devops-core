resource "aws_s3_bucket" "devops" {
  bucket = "bharper77-terraform"
}

resource "aws_s3_bucket_versioning" "devops" {
  bucket = aws_s3_bucket.devops.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
  bucket = aws_s3_bucket.devops.id

  rule {
    bucket_key_enabled = true
    apply_server_side_encryption_by_default {
      sse_algorithm = "aws:kms"
    }
  }
}

resource "aws_s3_bucket" "source" {
  bucket = local.source_bucket_name
}

resource "aws_s3_bucket" "destination" {
  bucket = local.destination_bucket_name
}

resource "aws_s3_bucket" "code" {
  bucket = local.code_bucket_name
}

resource "aws_s3_bucket_public_access_block" "source" {
  bucket = aws_s3_bucket.source.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "destination" {
  bucket = aws_s3_bucket.destination.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "code" {
  bucket = aws_s3_bucket.code.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_notification" "s3_notification" {
  bucket = aws_s3_bucket.source.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.pdf_splitter.arn
    events              = ["s3:ObjectCreated:*"]
    filter_suffix       = ".pdf"
  }
}

resource "aws_s3_object" "lambda_package" {
  bucket = aws_s3_bucket.code.id
  key    = "pdfsplitter/lambda.zip"
  source = "lambda.zip"
  etag   = filemd5("lambda.zip")
}

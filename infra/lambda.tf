resource "aws_lambda_function" "pdf_splitter" {
  # Wait for lambda package to be uploaded
  depends_on = [aws_s3_object.lambda_package]

  function_name = "pdf_splitter_lambda"
  runtime       = "python3.12"
  handler       = "lambda_function.lambda_handler"
  role          = aws_iam_role.lambda_role.arn
  s3_bucket     = aws_s3_bucket.code.bucket
  s3_key        = "pdfsplitter/lambda.zip"
  timeout       = 900
  environment {
    variables = {
      DEST_BUCKET = aws_s3_bucket.destination.bucket
    }
  }
}

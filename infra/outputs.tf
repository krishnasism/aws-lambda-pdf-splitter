output "source_bucket_name" {
  value       = aws_s3_bucket.source.bucket
  description = "The name of the source S3 bucket"
}

output "destination_bucket_name" {
  value       = aws_s3_bucket.destination.bucket
  description = "The name of the destination S3 bucket"
}

output "code_bucket_name" {
  value       = aws_s3_bucket.code.bucket
  description = "The name of the code S3 bucket"
}

output "source_bucket_url" {
  value       = "https://${aws_s3_bucket.source.bucket}.s3.amazonaws.com/"
  description = "The URL for the source S3 bucket"
}

output "destination_bucket_url" {
  value       = "https://${aws_s3_bucket.destination.bucket}.s3.amazonaws.com/"
  description = "The URL for the destination S3 bucket"
}

output "code_bucket_url" {
  value       = "https://${aws_s3_bucket.code.bucket}.s3.amazonaws.com/"
  description = "The URL for the code S3 bucket"
}

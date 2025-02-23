locals {
  account_id              = data.aws_caller_identity.current.account_id
  source_bucket_name      = "${var.source_bucket}-${local.account_id}"
  destination_bucket_name = "${var.destination_bucket}-${local.account_id}"
  code_bucket_name        = "${var.code_bucket}-${local.account_id}"
}

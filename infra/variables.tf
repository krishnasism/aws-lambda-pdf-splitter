variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "source_bucket" {
  type    = string
  default = "source"
}

variable "destination_bucket" {
  type    = string
  default = "destination"
}

variable "code_bucket" {
  type    = string
  default = "code"
}

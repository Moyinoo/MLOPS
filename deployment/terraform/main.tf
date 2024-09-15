terraform {
   backend "s3" {
    bucket         = "aimdla-state-file"
    key            = "state_lock_key"
    region         = "us-east-1"
    dynamodb_table = "state_lock"
    encrypt        = true
  }
  required_version = ">= 1.4.2"
}

# Retrieve aws credentials
data "aws_caller_identity" "current" {}


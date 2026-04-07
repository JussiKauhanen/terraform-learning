data "aws_caller_identity" "this" {}

terraform {
  required_version = "~> 1.14.8"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.23.0"
    }
  }
}

provider "aws" {
  region = "eu-west-1"
}

resource "aws_s3_bucket" "terraform_cloudshell_demo_step_1" {
  bucket = "terraform-learning-demo-${data.aws_caller_identity.this.account_id}"
}

/* ACL is no longer needed for S3's in this fashion
  resource "aws_s3_bucket_acl" "terraform-learning-demo" {
  bucket = aws_s3_bucket.terraform-learning-demo.id
  acl    = "private"
}*/
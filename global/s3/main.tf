terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.27.0"
    }
  }
}

provider "aws" {
  region     = "eu-west-2"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket        = var.amberdata_bucket
  force_destroy = true
}

resource "aws_s3_bucket_versioning" "enabled" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket                  = aws_s3_bucket.terraform_state.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = var.amberdata_table
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}

provider "aws" {
  region     = var.region
  access_key = "AKIASTN2GOGQSDN7WR5R"
  secret_key = "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"
}


terraform {
  backend "s3" {

    bucket  = "main-project-bucket"
    key     = "bookstore/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}
data "aws_region" "current" {}

terraform {
  backend "s3" {
    bucket = "bkraajus-test-terraform-remote-state"
    key = "bkcka"
    dynamodb_table = "bkraajus-test-terraform-remote-state-locks"
    region = "us-east-1"
  }
}
data "aws_region" "current" {}

terraform {
  backend "s3" {
    bucket = "bkrajus-test-terraform-remote-state"
    key = "bkcka"
    dynamodb_table = "bkrajus-test-terraform-remote-state-locks"
    region = "ap-southeast-1"
  }
}
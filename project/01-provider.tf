terraform {
  backend "s3" {
    bucket  = "subhamay-tf-remote-state-us-east-1/" // Bucket where to SAVE Terraform State
    key     = "0001-tarius/devl/terraform.tfstate"  // Object name in the bucket to SAVE Terraform State
    region  = "us-east-1"                           // Region where bucket created
    encrypt = true
  }
}

provider "aws" {
  region = "us-east-1"
}
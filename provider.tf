terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  // required_version = ">= 1.2.0"

}

terraform {
  backend "s3" {
	bucket = "ecs-ec2"
	region = "ap-south-1"
	key = "terraform.tfstate"
  }
}

provider "aws" {

  region     = "${var.region}"

  access_key = "${var.access_key}"

  secret_key = "${var.secret_key}"

}



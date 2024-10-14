provider "aws" {
  region  = local.env.region
  profile = local.env.profile
    # region = us-east-1
}

terraform {
  required_version = ">= 1.5.7"

    backend "s3" {
      profile = "default"
      bucket  = "redis-circleci"
      key     = "tfstate/task"
      region  = "us-east-1"
    }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.71.0"
    }
  }
}
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Default Provider - Mumbai
provider "aws" {
  region = "ap-south-1"
}

# Second Provider - US East (N. Virginia)
provider "aws" {
  alias  = "useast"
  region = "us-east-1"
}

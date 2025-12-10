terraform {
  backend "s3" {
    bucket         = "ecs-assignment-v2-terraform-state-dev"
    key            = "ecs-assignment-v2/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "ecs-assignment-v2-dynamodb-lock"
    encrypt        = true
    
  }
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}
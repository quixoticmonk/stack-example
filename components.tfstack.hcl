variable "bucket_name" {
    type=string
}

variable "rule_name" {
  type = string
  
}

variable "topic_name" {
  type = string
}

required_providers {
  aws = {
    source  = "hashicorp/aws"
    version = "5.40.0"
  }

}

provider "aws" "this" {}

component "s3" {
    source = "./s3"
    inputs={
        bucket_name = var.bucket_name

    }
    providers={
        aws= provider.aws.this
    }
}

component "events" {
    source = "./events"
    inputs={
        rule_name = var.rule_name   
        topic_name = var.topic_name

    }
    providers={
        aws= provider.aws.this
    }
}
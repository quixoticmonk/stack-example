variable "bucket_name" {
    type=string
}

variable "rule_name" {
  type = string
  
}

variable "topic_name" {
  type = string
}

variable "region" {
  type = string
}

variable "aws_token" {
  type      = string
  ephemeral = true
}

variable "role_arn" {
  type = string
}
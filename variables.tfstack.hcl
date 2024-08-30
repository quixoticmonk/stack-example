
variable "name" {
  type = string
  
}

variable "tags" {
  type = list(object({
    key = string
    value = string
  }))
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
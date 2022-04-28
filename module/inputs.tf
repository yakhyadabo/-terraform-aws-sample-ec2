variable "region" {
  type = string
  default = "us-east-1"
}

variable "vpc_id" {
  type = string
  description = "The id of the vpc"
}

variable "key_name" {
  type = string
  description = "Name of the key pair created in AWS"
}
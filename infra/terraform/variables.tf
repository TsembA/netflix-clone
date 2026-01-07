variable "aws_region" {
  type        = string
}

variable "project_name" {
  type        = string
}

variable "environment" {
  type        = string
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for VPC"
  default     = "10.20.0.0/16"
}

variable "az_count" {
  type        = number
  description = "Number of AZs"
  default     = 2
}

variable "cluster_name" {
  type        = string
  description = "EKS cluster name"
}

variable "cluster_version" {
  type    = string
  default = "1.32"
}

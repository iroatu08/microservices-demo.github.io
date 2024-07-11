variable "region" {
  description = "The AWS region to deploy the infrastructure"
  default     = "us-west-2"
}

variable "cluster_name" {
  description = "The name of the EKS cluster"
  default     = "sock-shop-cluster"
}

variable "node_instance_type" {
  description = "The EC2 instance type for the worker nodes"
  default     = "t2.medium"
}

variable "desired_capacity" {
  description = "The desired number of worker nodes"
  default     = 2
}

variable "max_size" {
  description = "The maximum number of worker nodes"
  default     = 3
}

variable "min_size" {
  description = "The minimum number of worker nodes"
  default     = 1
}

variable "vpc_id" {
  description = "The ID of the VPC"
}

variable "subnet_ids" {
  description = "The IDs of the subnets"
  type        = list(string)
}

variable "eks_role_arn" {
  description = "The ARN of the IAM role for EKS"
}

variable "managed_policy_arns" {
  description = "The ARNs of the managed policies to attach to the EKS worker node IAM role"
  type        = list(string)
}
